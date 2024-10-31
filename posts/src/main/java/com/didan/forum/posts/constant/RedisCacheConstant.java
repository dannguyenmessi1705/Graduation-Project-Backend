package com.didan.forum.posts.constant;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum RedisCacheConstant {
  USER_CACHE("userdata"),
  COMMENT_QUANTITY_CACHE("commentquantity");

  private String cacheName;
  RedisCacheConstant(String cacheName) {
    this.cacheName = cacheName;
  }
}
