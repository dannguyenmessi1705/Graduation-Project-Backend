package com.didan.forum.chats.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Column;
import jakarta.persistence.Lob;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@Schema(
    name = "CreateMessageRequestDto",
    description = "The request dto for creating a message"
)
public class CreateMessageRequestDto {
  @Schema(
      name = "id",
      description = "The id of the message",
      example = "1"
  )
  private String id;

  @Schema(
      name = "content",
      description = "The content of the message",
      example = "Hello, how are you?"
  )
  private String content;

  @Schema(
      name = "senderId",
      description = "The id of the sender",
      example = "1"
  )
  private String senderId;

  @Schema(
      name = "receiverId",
      description = "The id of the receiver",
      example = "2"
  )
  
  private String receiverId;

  @Schema(
      name = "isRead",
      description = "The status of the message",
      example = "false"
  )
  private Boolean isRead;

  @Schema(
      name = "roomId",
      description = "The id of the room",
      example = "1"
  )
  private String roomId;

  @Schema(
      name = "files",
      description = "The files attached to the message"
  )
  private MultipartFile[] files;
}
