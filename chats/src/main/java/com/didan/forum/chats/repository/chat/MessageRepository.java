package com.didan.forum.chats.repository.chat;

import com.didan.forum.chats.entity.chat.MessageEntity;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MessageRepository extends JpaRepository<MessageEntity, String> {

  List<MessageEntity> findMessageEntitiesByRoom_IdAndContentContainingIgnoreCase(String roomId,
      String content);

  Iterable<MessageEntity> findMessageEntitiesByRoom_Id(String roomId);

  Iterable<MessageEntity> findMessageEntitiesByRoom_IdAndFileAttachedIsNotNull(String roomId);

}
