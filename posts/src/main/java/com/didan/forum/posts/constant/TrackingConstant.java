package com.didan.forum.posts.constant;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum TrackingConstant {
  TRACE_ID("traceId"),
  SPAN_ID("spanId"),
  X_USER_ID("X-User-Id"),
  CORRELATION_ID("correlationId"),
  X_REQUEST_ID("X-Request-Id"),
  USER_AGENT("user-agent"),
  APP_VERSION("appVersion"),
  TYPE_OS("type-os"),
  OS_VERSION("os-version"),
  X_FORWARD_FOR("x-forwarded-for"),
  X_ORIGINAL_FORWARD_FOR("x-original-forwarded-for"),
  X_REAL_IP("x-real-ip"),
  DURATION("duration");

  private String headerKey;

  TrackingConstant(String headerKey) {
    this.headerKey = headerKey;
  }
}
