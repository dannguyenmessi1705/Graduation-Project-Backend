package com.didan.forum.posts.constant;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum VoteType {
  UPVOTE("up"),
  DOWNVOTE("down");

  private String name;

  VoteType(String name) {
    this.name = name;
  }
}

