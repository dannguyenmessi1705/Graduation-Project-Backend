package com.didan.forum.chats.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Message {
  private MessageType messageType;
  private String content;
  private String sender;
  private String receiver;
  private String sessionId;

  public static enum MessageType {
    CHAT,
    CONNECT,
    DISCONNECT
  }
}
