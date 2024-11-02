package com.didan.forum.chats.config.websocket;

import com.didan.forum.chats.service.VerifyUserService;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

@Slf4j
@RequiredArgsConstructor
public class CustomHandshakeInterceptor implements HandshakeInterceptor {
  private final VerifyUserService verifyUserService;

  @Override
  public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
      WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
    log.info("HandshakeInterceptor: {}", request.getURI());
    String userId = getUserId(request.getURI().getQuery());
    if (StringUtils.hasText(userId) && verifyUserService.verifyUser(userId)) {
      attributes.put("userId", userId);
      return true;
    }
    log.error("User is not authenticated: {}", userId);
    return false;
  }

  @Override
  public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
      WebSocketHandler wsHandler, Exception exception) {
    log.info("After HandshakeInterceptor: {}", request.getHeaders());
  }

  private String getUserId(String s) {
    int userIdStartIdx = s.indexOf("userId=") + "userId=".length();
    int userIdEndIdx = s.indexOf("&", userIdStartIdx);
    if (userIdEndIdx == -1) {
      userIdEndIdx = s.length();
    }
    return s.substring(userIdStartIdx, userIdEndIdx);
  }
}
