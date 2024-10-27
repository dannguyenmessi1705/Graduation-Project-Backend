package com.didan.forum.posts.constant;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum SearchType {
  TITLE("title"),
  CONTENT("content");
  private String type;
  SearchType(String type) {
    this.type = type;
  }
}
