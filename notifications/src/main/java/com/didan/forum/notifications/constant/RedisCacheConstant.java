package com.didan.forum.notifications.constant;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum RedisCacheConstant {
  USER_CACHE("userdata"),
  NOTIFICATION_UNREAD_COUNT("notificationunreadcount"),
  COMMENT_QUANTITY_CACHE("commentquantity");

  private String cacheName;
  RedisCacheConstant(String cacheName) {
    this.cacheName = cacheName;
  }
}
