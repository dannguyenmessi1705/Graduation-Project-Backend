package com.didan.forum.comments.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class CommentInteractionScoreMessage {
  private String commentId;
  private Long interactionScore;

}
