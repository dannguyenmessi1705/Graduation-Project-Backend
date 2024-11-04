package com.didan.forum.notifications.function;

import com.didan.forum.notifications.constant.RedisCacheConstant;
import com.didan.forum.notifications.dto.NotificationKafkaCommon;
import com.didan.forum.notifications.dto.UserJoinProducer;
import com.didan.forum.notifications.entity.notification.NotificationEntity;
import com.didan.forum.notifications.repository.notification.NotificationRepository;
import com.didan.forum.notifications.service.IRedisService;
import com.didan.forum.notifications.utils.MapperUtils;
import java.util.function.Consumer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.util.StringUtils;

@Configuration
@Slf4j
public class NotificationFunction {

  @Value("${app.websocket.subscribe}")
  private String subscribeEndpoint;

  @Bean
  public Consumer<NotificationKafkaCommon> listenNotification(
      NotificationRepository notificationRepository,
      SimpMessageSendingOperations simpMessageSendingOperations,
      IRedisService redisService) {
    return notificationKafkaCommon -> {
      log.info("Notification received: {}", notificationKafkaCommon);
      NotificationEntity notificationEntity = MapperUtils.map(notificationKafkaCommon,
          NotificationEntity.class);
      if (StringUtils.hasText(notificationEntity.getUserId())) {
        simpMessageSendingOperations.convertAndSend(
            subscribeEndpoint + "/private/" + notificationEntity.getUserId(), notificationEntity);
      } else {
        notificationEntity.setIsRead(false);
        simpMessageSendingOperations.convertAndSend(subscribeEndpoint + "/public",
            notificationEntity);
      }
      notificationRepository.save(notificationEntity);
      redisService.deleteCache(RedisCacheConstant.NOTIFICATION_UNREAD_COUNT.getCacheName(), notificationEntity.getUserId());
    };
  }

  @Bean
  Consumer<UserJoinProducer> listenUserJoinForum(
      SimpMessageSendingOperations simpMessageSendingOperations) {
    return userJoinProducer -> {
      log.info("User {} joined the forum", userJoinProducer.getUserId());
      simpMessageSendingOperations.convertAndSend(subscribeEndpoint + "/public",
          userJoinProducer);
    };
  }
}
