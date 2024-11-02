package com.didan.forum.chats.dto;

import io.swagger.v3.oas.annotations.media.Schema;
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
public class CreateMessageProducer {
  private String id;

  private String content;

  private String senderId;

  private String receiverId;

  private Boolean isRead;

  private String roomId;

  private List<String> files;
}
