package com.didan.forum.users.constant;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum ReportType {
  USER("user"),
  POST("post"),
  COMMENT("comment"),
  CHAT("chat");

  private String reportType;

  ReportType(String reportType) {
    this.reportType = reportType;
  }
}
