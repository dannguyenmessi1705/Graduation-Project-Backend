package com.didan.forum.users.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class ReportUserDto {
  @Schema(
      name = "content",
      description = "The content of the report",
      example = "This post is inappropriate"
  )
  @NotBlank(message = "blank.field.content")
  private String content;
}
