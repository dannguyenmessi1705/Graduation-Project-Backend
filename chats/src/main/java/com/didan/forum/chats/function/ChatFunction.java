package com.didan.forum.chats.function;

import com.didan.forum.chats.dto.CreateMessageProducer;
import com.didan.forum.chats.entity.chat.UserChatStatusEntity;
import com.didan.forum.chats.repository.chat.UserChatStatusRepository;
import java.util.function.Consumer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.SimpMessageSendingOperations;

@Configuration
@Slf4j
public class ChatFunction {
  @Bean
  public Consumer<CreateMessageProducer> listenChat(SimpMessageSendingOperations messageTemplate) {
    return message -> {
      log.info("Message sent to Kafka: {}", message);
      messageTemplate.convertAndSend("/topic/private" + message.getRoomId(), message);
    };
  }

  @Bean
  public Consumer<CreateMessageProducer> listenJoin(SimpMessageSendingOperations messageTemplate) {
    return message -> {
      log.info("Message sent to Kafka: {}", message);
      messageTemplate.convertAndSend("/topic/private" + message.getRoomId(), message);
    };
  }

  @Bean
  public Consumer<CreateMessageProducer> listenUpdateCountUnread(UserChatStatusRepository userChatStatusRepository) {
    return message -> {
      log.info("Message sent to Kafka: {}", message);
      UserChatStatusEntity userChatStatusEntity = userChatStatusRepository.findUserChatStatusEntityByUserIdAndRoom_Id(
          message.getReceiverId(), message.getRoomId()).orElse(null);
      if (userChatStatusEntity != null) {
        userChatStatusEntity.setUnreadCount(userChatStatusEntity.getUnreadCount() + 1);
        userChatStatusRepository.save(userChatStatusEntity);
      }
    };
  }
}
