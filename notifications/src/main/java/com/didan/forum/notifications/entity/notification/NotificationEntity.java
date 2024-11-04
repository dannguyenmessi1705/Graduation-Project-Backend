package com.didan.forum.notifications.entity.notification;

import com.didan.forum.notifications.constant.NotifyTypeConstant;
import com.didan.forum.notifications.entity.SuperClass;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "notification")
@Table(
    indexes = {
        @Index(name = "idx_user_id", columnList = "user_id"),
        @Index(name = "idx_is_read", columnList = "is_read")
    }
)
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class NotificationEntity extends SuperClass {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "user_id", nullable = true)
  private String userId;

  @Column(name = "title", nullable = false)
  private String title;

  @Column(name = "content", nullable = false)
  private String content;

  @Column(name = "type", nullable = false)
  @Enumerated(EnumType.STRING)
  private NotifyTypeConstant type;

  @Column(name = "link", nullable = true)
  private String link;

  @Column(columnDefinition = "TINYINT(1)", name = "is_read")
  private Boolean isRead = false;
}
