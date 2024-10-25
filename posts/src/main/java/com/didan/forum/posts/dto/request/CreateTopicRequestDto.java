package com.didan.forum.posts.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Schema(
    name = "CreateTopicRequest",
    description = "Request to create a new topic"
)
@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class CreateTopicRequestDto {
  @Schema(
      name = "name",
      description = "Name of the topic",
      example = "Notification System"
  )
  @NotBlank(message = "blank.field.topic.name")
  @Size(min = 3, max = 255, message = "invalid.field.topic.name")
  @Pattern(regexp = "^[a-zA-Z0-9 ]+$", message = "invalid.field.topic.name")
  private String name;
}
