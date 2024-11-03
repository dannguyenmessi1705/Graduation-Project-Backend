package com.didan.forum.notifications.config.websocket;

import com.didan.forum.notifications.service.VerifyUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketTransportRegistration;

@Configuration
@RequiredArgsConstructor
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
  private final VerifyUserService verifyUserService;

  @Value("${app.websocket.endpoint}")
  private String endpoint;

  @Value("${app.websocket.publish}")
  private String publishEndpoint;

  @Value("${app.websocket.subscribe}")
  private String subscribeEndpoint;

  @Override
  public void registerStompEndpoints(StompEndpointRegistry registry) {
    registry
        .addEndpoint(endpoint)
        .setAllowedOriginPatterns("*")
        .withSockJS()
        .setInterceptors(new CustomHandshakeInterceptor(verifyUserService));
  }

  @Override
  public void configureWebSocketTransport(WebSocketTransportRegistration registry) {
    registry.setMessageSizeLimit(1024 * 10);
    registry.setSendBufferSizeLimit(1024 * 10);
    registry.setSendTimeLimit(20000);
  }

  @Override
  public void configureClientInboundChannel(ChannelRegistration registration) {
    registration.taskExecutor().corePoolSize(4); // Số lượng core pool dùng để xử lý message
    registration.taskExecutor().maxPoolSize(10); // Số lượng max pool dùng để xử lý message
    registration.taskExecutor().keepAliveSeconds(60); // Thời gian mà thread sẽ được giữ lại sau khi xử lý xong message
    registration.taskExecutor().queueCapacity(25); // Số lượng message được giữ lại trong queue
  }

  @Override
  public void configureClientOutboundChannel(ChannelRegistration registration) {
    registration.taskExecutor().corePoolSize(4);
    registration.taskExecutor().maxPoolSize(10);
    registration.taskExecutor().keepAliveSeconds(60);
    registration.taskExecutor().queueCapacity(25);
  }

  @Override
  public void configureMessageBroker(MessageBrokerRegistry registry) {
    registry.enableSimpleBroker(subscribeEndpoint);
    registry.setApplicationDestinationPrefixes(publishEndpoint);
  }
}
