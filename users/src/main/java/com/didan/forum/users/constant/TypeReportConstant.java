package com.didan.forum.users.constant;

import lombok.Getter;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@Getter
public enum TypeReportConstant {
  REPORT_USER("user", "Report user"),
  REPORT_POST("post", "Report post"),
  REPORT_CHAT("chat", "Report chat"),
  REPORT_COMMENT("comment", "Report comment");

  private String type;
  private String description;

  TypeReportConstant(String type, String description) {
    this.type = type;
    this.description = description;
  }
}
