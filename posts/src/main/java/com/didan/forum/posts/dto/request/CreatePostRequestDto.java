package com.didan.forum.posts.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.validation.constraints.NotBlank;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Schema(
    name = "CreatePostRequestDto",
    description = "Request body for creating a post"
)
@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class CreatePostRequestDto {
  @Schema(
      name = "topicId",
      description = "The ID of the topic to which the post belongs",
      example = "71c3b1b1-1b1b-1b1b-1b1b-1b1b1b1b1b1b"
  )
  @NotBlank(message = "blank.field.topicId")
  private String topicId;

  @Schema(
      name = "title",
      description = "The title of the post",
      example = "How to create a post"
  )
  @NotBlank(message = "blank.field.title")
  private String title;

  @Schema(
      name = "content",
      description = "The content of the post",
      example = "To create a post, you need to follow these steps..."
  )
  @NotBlank(message = "blank.field.content")
  private String content;

  @Schema(
      name = "files",
      description = "The files attached to the post"
  )
  private MultipartFile[] files;
}
