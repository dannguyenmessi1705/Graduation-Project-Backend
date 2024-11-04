package com.didan.forum.comments.dto.client;

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
public class PostResponseDto {
  private String id;
  private String title;
  private String content;
  private String topicId;
  private UserInfo author;
  private List<String> fileAttachments;
  private Long totalComments;
  private Long totalUpvotes;
  private Long totalDownvotes;
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
