package com.didan.forum.notifications.dto;

import com.didan.forum.notifications.constant.NotifyTypeConstant;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Column;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.NotBlank;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class NotificationConsumer {
  @Column(name = "user_id", nullable = false)
  private String userId;

  private String message;

  private NotifyTypeConstant type;

  private String link;
}
