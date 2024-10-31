package com.didan.forum.comments.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class PostInteractionScoreMessage {
  private String postId;
  private Long interactionScore;

}
