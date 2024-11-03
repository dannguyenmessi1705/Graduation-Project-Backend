package com.didan.forum.notifications.function;

import com.didan.forum.notifications.dto.NotificationConsumer;
import com.didan.forum.notifications.dto.UserJoinProducer;
import com.didan.forum.notifications.entity.notification.NotificationEntity;
import com.didan.forum.notifications.repository.notification.NotificationRepository;
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
  public Consumer<NotificationConsumer> listenNotification(
      NotificationRepository notificationRepository,
      SimpMessageSendingOperations simpMessageSendingOperations) {
    return notificationConsumer -> {
      log.info("Notification received: {}", notificationConsumer);
      NotificationEntity notificationEntity = MapperUtils.map(notificationConsumer,
          NotificationEntity.class);
      if (StringUtils.hasText(notificationEntity.getUserId())) {
        simpMessageSendingOperations.convertAndSend(
            subscribeEndpoint + "/private/" + notificationEntity.getUserId(), notificationEntity);
      } else {
        simpMessageSendingOperations.convertAndSend(subscribeEndpoint + "/public",
            notificationEntity);
      }
      notificationRepository.save(notificationEntity);
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
