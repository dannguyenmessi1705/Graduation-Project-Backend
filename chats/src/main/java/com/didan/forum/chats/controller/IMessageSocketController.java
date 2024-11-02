package com.didan.forum.chats.controller;

import com.didan.forum.chats.dto.request.CreateMessageRequestDto;
import com.didan.forum.chats.dto.request.Message;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;

public interface IMessageSocketController {
  @MessageMapping("/send")
  void sendMessage(@Payload CreateMessageRequestDto requestDto,
      SimpMessageHeaderAccessor headerAccessor);

  @MessageMapping("/join")
  void joinAction(@Payload CreateMessageRequestDto requestDto, SimpMessageHeaderAccessor headerAccessor);
}
