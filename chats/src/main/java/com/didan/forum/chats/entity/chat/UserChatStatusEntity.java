package com.didan.forum.chats.entity.chat;

import com.didan.forum.chats.entity.SuperClass;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "user_chat_status")
@Table(
    indexes = {
        @jakarta.persistence.Index(name = "idx_user_id", columnList = "user_id"),
        @jakarta.persistence.Index(name = "idx_room_id", columnList = "room_id")
    }
)
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class UserChatStatusEntity extends SuperClass {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "user_id")
  private String userId;

  @ManyToOne
  @JsonBackReference
  @JoinColumn(name = "room_id")
  private RoomEntity room;

  @Column(name = "unread_count")
  private Long unreadCount;
}
