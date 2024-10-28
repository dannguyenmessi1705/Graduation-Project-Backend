package com.didan.forum.posts.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.jetbrains.annotations.NotNull;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class ReportPostDto {
  @Schema(
      name = "content",
      description = "The content of the report",
      example = "This post is inappropriate"
  )
  @NotBlank(message = "blank.field.content")
  private String content;
}
