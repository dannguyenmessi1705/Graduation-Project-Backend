package com.didan.forum.chats.repository.chat;

import com.didan.forum.chats.entity.chat.RoomEntity;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface RoomRepository extends JpaRepository<RoomEntity, String> {

  @Query(value = "SELECT r FROM room r WHERE (r.userCreatorId = ?1 AND r.userJoinerId = ?2) OR (r.userCreatorId = ?2 AND r.userJoinerId = ?1) ORDER BY COALESCE(r.updatedAt, r.createdAt) DESC")
  Optional<RoomEntity> findRoomsByUserCreatorIdOrUserJoinerId(String userId1, String userId2);

}
