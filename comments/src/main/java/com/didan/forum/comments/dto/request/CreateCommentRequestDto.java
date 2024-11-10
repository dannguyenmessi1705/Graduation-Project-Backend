package com.didan.forum.comments.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Schema(
    name = "CreateCommentRequestDto",
    description = "Request object to create a comment"
)
@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class CreateCommentRequestDto {
  @Schema(
      name = "content",
      description = "Content of the comment",
      example = "This is a comment"
  )
  @NotBlank(message = "blank.field.content")
  private String content;

  @Schema(
      name = "postId",
      description = "Id of the post to which the comment belongs",
      example = "185362356824"
  )
  @NotBlank(message = "blank.field.postId")
  private String postId;

  @Schema(
      name = "replyToCommentId",
      description = "Id of the comment to which the comment is a reply",
      example = "185362356824",
      nullable = true
  )
  private String replyToCommentId;


  @Schema(
      name = "files",
      description = "The files attached to the post",
      nullable = true
  )
  private List<MultipartFile> files;

}
