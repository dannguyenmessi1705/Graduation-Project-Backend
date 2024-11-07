package com.didan.forum.notifications.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class LogSystemEntity {
  private String applicationCode;
  private String requestID;
  private String sessionID;
  private String requestContent;
  private String responseContent;
  private String startTime;
  private String endTime;
  private String duration;
  private String statusCode;
  private String message;
  private String requestStatus;
  private String actionName;
  private String apiPath;
  private String username;
  private String client;
  private String userAgent;
  private String spanId;
  private String correlationId;
  private String typeOS;
  private String osVersion;
  private String appVersion;
}
