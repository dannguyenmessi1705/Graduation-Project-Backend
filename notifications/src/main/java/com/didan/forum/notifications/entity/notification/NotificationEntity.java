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
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "notification")
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class NotificationEntity extends SuperClass {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Schema(
      name = "userId",
      description = "User ID of the user who will receive the notification",
      example = "114514"
  )
  @Column(name = "user_id", nullable = true)
  private String userId;

  @Schema(
      name = "message",
      description = "Message of the notification",
      example = "You have a new message"
  )
  @NotBlank(message = "blank.field.message")
  @Column(name = "message")
  private String message;

  @Schema(
      name = "type",
      description = "Type of the notification",
      example = "POST"
  )
  @NotBlank(message = "blank.field.notification.type")
  @Column(name = "type")
  @Enumerated(EnumType.STRING)
  private NotifyTypeConstant type;

  @Schema(
      name = "link",
      description = "Link of the notification",
      example = "/post/114514"
  )
  @Column(name = "link")
  private String link;

  @Schema(
      name = "isRead",
      description = "Whether the notification has been read",
      example = "true"
  )
  @Column(columnDefinition = "TINYINT(1)", name = "is_read")
  private Boolean isRead = false;
}
