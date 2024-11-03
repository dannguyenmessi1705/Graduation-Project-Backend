package com.didan.forum.notifications.controller.impl;

import com.didan.forum.notifications.dto.UserJoinProducer;
import java.util.Objects;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;

@Controller
@AllArgsConstructor
@Slf4j
public class MessageSocketControllerImpl {
  private final StreamBridge streamBridge;

  @MessageMapping("/join")
  public void joinAction(@Payload UserJoinProducer requestDto,
      SimpMessageHeaderAccessor headerAccessor) {
    log.info("User {} joined the forum", Objects.requireNonNull(
        headerAccessor.getSessionAttributes()).get("userId"));
    try {
      requestDto.setSessionId(headerAccessor.getSessionId());
      streamBridge.send("userJoinForum-out-0", requestDto);
    } catch (Exception e) {
      log.error("Error occurred while sending message: {}", e.getMessage());
    }
  }
}
