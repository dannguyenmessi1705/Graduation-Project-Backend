package com.didan.forum.gatewayserver.constant;

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
  USER_AGENT("User-Agent"),
  DURATION("duration");

  private String headerKey;

  TrackingConstant(String headerKey) {
    this.headerKey = headerKey;
  }
}
