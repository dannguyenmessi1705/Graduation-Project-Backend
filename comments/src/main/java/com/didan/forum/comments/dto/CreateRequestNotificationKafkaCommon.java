package com.didan.forum.comments.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class CreateRequestNotificationKafkaCommon {
  private String commentId;
  private String postId;
  private String userCommentId;
  private String ownerCommentId;
  private String commentContent;
}
