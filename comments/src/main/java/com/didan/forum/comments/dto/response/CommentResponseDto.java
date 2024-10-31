package com.didan.forum.comments.dto.response;

import java.time.LocalDateTime;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class CommentResponseDto {
  private String id;
  private String postId;
  private String replyToCommentId;
  private UserInfo author;
  private String content;
  private Long totalUpvotes;
  private Long totalDownvotes;
  private List<String> fileAttachments;
  private LocalDateTime createdAt;
  private LocalDateTime updatedAt;

  @AllArgsConstructor
  @NoArgsConstructor
  @Data
  @Builder
  public static class UserInfo {
    private String id;
    private String username;
    private String email;
  }
}
