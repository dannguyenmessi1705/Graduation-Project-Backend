package com.didan.forum.posts.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class UpdatePostRequestDto {
  private String title;
  private String content;
  private MultipartFile[] files;
}
