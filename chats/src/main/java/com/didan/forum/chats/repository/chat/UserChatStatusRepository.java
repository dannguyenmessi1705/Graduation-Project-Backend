package com.didan.forum.chats.repository.chat;

import com.didan.forum.chats.entity.chat.UserChatStatusEntity;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserChatStatusRepository extends JpaRepository<UserChatStatusEntity, Long> {
  Optional<UserChatStatusEntity> findUserChatStatusEntityByUserIdAndRoom_Id(String userId,
      String roomId);
}
