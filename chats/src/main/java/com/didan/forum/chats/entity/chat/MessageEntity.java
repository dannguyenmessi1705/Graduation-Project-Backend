package com.didan.forum.chats.entity.chat;

import com.didan.forum.chats.entity.SuperClass;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import java.util.List;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "message")
@Table(
    indexes = {
        @jakarta.persistence.Index(name = "idx_sender_id", columnList = "sender_id"),
        @jakarta.persistence.Index(name = "idx_receiver_id", columnList = "receiver_id"),
        @jakarta.persistence.Index(name = "idx_room_id", columnList = "room_id")
    }
)
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class MessageEntity extends SuperClass {
  @Id
  private String id;

  @Column(name = "content", columnDefinition = "TEXT")
  private String content;

  @Column(name = "sender_id")
  private String senderId;

  @Column(name = "receiver_id")
  private String receiverId;

  @Column(columnDefinition = "TINYINT(1)", name = "is_read")
  private Boolean isRead;

  @Lob
  @Column(name = "file_attached", length = 16777216)
  private List<String> fileAttached;

  @ManyToOne
  @JsonBackReference
  @JoinColumn(name = "room_id")
  private RoomEntity room;

  @PrePersist
  public void prePersist() {
    this.id = this.id == null ? UUID.randomUUID().toString() : this.id;
  }
}
