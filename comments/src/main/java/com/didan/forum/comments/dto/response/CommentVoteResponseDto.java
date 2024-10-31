package com.didan.forum.comments.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class CommentVoteResponseDto {
  private String userId;
  private String username;
  private String fullName;
}
