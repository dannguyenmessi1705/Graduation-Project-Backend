package com.didan.forum.notifications.dto;

import com.didan.forum.notifications.constant.NotifyTypeConstant;
import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class NotificationKafkaCommon {
  private String userId;

  private String title;

  private String content;

  private NotifyTypeConstant type;

  private String link;
}
