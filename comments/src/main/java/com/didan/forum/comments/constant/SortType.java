package com.didan.forum.comments.constant;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum SortType {
  HOT("hot"),
  NEW("new");

  private String type;

  SortType(String type) {
    this.type = type;
  }
}
