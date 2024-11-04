package com.didan.forum.users.dto;

import com.didan.forum.users.constant.NotifyTypeConstant;
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
