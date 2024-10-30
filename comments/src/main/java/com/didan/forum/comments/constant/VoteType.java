package com.didan.forum.comments.constant;

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

  public static VoteType fromString(String name) {
    for (VoteType voteType : VoteType.values()) {
      if (voteType.getName().equalsIgnoreCase(name)) {
        return voteType;
      }
    }
    throw new IllegalArgumentException("No enum constant for value: " + name);
  }
}

