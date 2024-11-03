package com.didan.forum.notifications.dto;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class UserJoinProducer {
  private String userId;
  private String username;
  private String sessionId;
  private LocalDateTime joinTime = LocalDateTime.now();
}
