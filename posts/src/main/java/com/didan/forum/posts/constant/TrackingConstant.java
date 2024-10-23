package com.didan.forum.posts.constant;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum TrackingConstant {
  TRACE_ID("Trace-Id"),
  SPAN_ID("Span-Id"),
  X_USER_ID("X-User-Id");

  private String headerKey;

  TrackingConstant(String headerKey) {
    this.headerKey = headerKey;
  }
}
