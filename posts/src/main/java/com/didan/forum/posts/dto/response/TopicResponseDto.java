package com.didan.forum.posts.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class TopicResponseDto {
  private String id;
  private String name;
  private Long totalPosts = 0L;
}
