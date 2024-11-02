package com.didan.forum.chats.entity.chat;

import com.didan.forum.chats.entity.SuperClass;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.util.List;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "room")
@Table(
    indexes = {
        @Index(name = "idx_user_creator_id", columnList = "user_creator_id"),
        @Index(name = "idx_user_joiner_id", columnList = "user_joiner_id")
    },
    uniqueConstraints = {
        @UniqueConstraint(columnNames = {"user_creator_id", "user_joiner_id"})
    }
)
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class RoomEntity extends SuperClass {
  @Id
  private String id;

  @Column(name = "user_creator_id")
  private String userCreatorId;

  @Column(name = "user_joiner_id")
  private String userJoinerId;

  @OneToMany(mappedBy = "room", cascade = CascadeType.REMOVE, fetch = FetchType.EAGER)
  @JsonManagedReference
  private List<MessageEntity> messages;

  @OneToMany(mappedBy = "room", cascade = CascadeType.REMOVE, fetch = FetchType.EAGER)
  @JsonManagedReference
  private List<UserChatStatusEntity> userChatStatusEntities;

  @PrePersist
  public void prePersist() {
    this.id = this.id == null ? UUID.randomUUID().toString() : this.id;
  }
}
