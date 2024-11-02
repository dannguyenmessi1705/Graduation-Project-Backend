package com.didan.forum.chats.controller.impl;

import com.didan.forum.chats.controller.IMessageSocketController;
import com.didan.forum.chats.dto.request.CreateMessageRequestDto;
import com.didan.forum.chats.dto.request.Message;
import com.didan.forum.chats.service.MessageSocketService;
import java.util.Objects;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;

@Controller
@AllArgsConstructor
@Slf4j
public class MessageSocketControllerImpl implements IMessageSocketController {
  private final MessageSocketService messageSocketService;

  @Override
  public void sendMessage(CreateMessageRequestDto requestDto,
      SimpMessageHeaderAccessor headerAccessor) {
    try {
      log.info("User {} creating a message: {}", Objects.requireNonNull(
          headerAccessor.getSessionAttributes()).get("userId"), requestDto);
      requestDto.setId(headerAccessor.getSessionId());
      messageSocketService.sendMessage(requestDto);
    } catch (Exception e) {
      log.error("Error occurred while sending message: {}", e.getMessage());
    }

  }

  @Override
  public void joinAction(CreateMessageRequestDto requestDto, SimpMessageHeaderAccessor headerAccessor) {
    log.info("User {} joined the chat", Objects.requireNonNull(
        headerAccessor.getSessionAttributes()).get("userId"));
    try {
      requestDto.setId(headerAccessor.getSessionId());
      messageSocketService.joinAction(requestDto);
    } catch (Exception e) {
      log.error("Error occurred while sending message: {}", e.getMessage());
    }
  }
}
