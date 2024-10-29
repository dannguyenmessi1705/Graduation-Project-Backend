package com.didan.forum.posts.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.checkerframework.checker.units.qual.A;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class PostInteractionScoreMessage {
  private String postId;
  private Long interactionScore;

}
