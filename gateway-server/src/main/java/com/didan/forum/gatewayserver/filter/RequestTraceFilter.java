package com.didan.forum.gatewayserver.filter;

import com.didan.forum.gatewayserver.constant.TrackingConstant;
import java.util.Set;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpHeaders;
import org.springframework.security.oauth2.jwt.ReactiveJwtDecoder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Order(1)
@Component
@Slf4j
@RequiredArgsConstructor
public class RequestTraceFilter implements GlobalFilter {

  private final FilterUtils filterUtils;
  private final ReactiveJwtDecoder jwtDecoder;

  @Value("${private.route}")
  Set<String> privateRoutes;

  @Value("${spring.application.name}")
  private String applicationName;

  @Override
  public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
    MDC.put(TrackingConstant.SPAN_ID.getHeaderKey(), generateSpanId());
    HttpHeaders httpHeaders = exchange.getRequest().getHeaders();
    String path = exchange.getRequest().getPath().toString();
    String traceId = generateTraceId();
    filterUtils.setTraceId(exchange, traceId);
    log.debug("trace-id generated in tracking filter: {}.", traceId);
    if (privateRoutes.stream().anyMatch(path::contains)) {
      String authHeader = httpHeaders.getFirst("Authorization");
      if (StringUtils.hasText(authHeader) && authHeader.startsWith("Bearer ")) {
        String token = authHeader.substring(7);
        return jwtDecoder.decode(token).flatMap(
            jwtToken -> {
              String sub = jwtToken.getClaimAsString("sub");
              if (StringUtils.hasText(sub)) {
                filterUtils.setxUserId(exchange, sub);
                log.debug("forum-x-user-id generated in tracking filter: {}.", sub);
              }
              return chain.filter(exchange);

            }
        ).onErrorResume(e -> {
          log.error("Error decoding token", e);
          return chain.filter(exchange);
        });
      }
    }
    return chain.filter(exchange).doFinally(
        signalType -> {
          MDC.clear();
        }
    );
  }

  private boolean isTraceIdPresent(HttpHeaders httpHeaders) {
    return filterUtils.getTraceId(httpHeaders) != null;
  }

  private boolean isXUserIdPresent(HttpHeaders httpHeaders) {
    return filterUtils.getxUserId(httpHeaders) != null;
  }

  private String generateTraceId() {
    return java.util.UUID.randomUUID().toString();
  }

  private String generateSpanId() {
    return String.format("%s-%s", applicationName,
        UUID.randomUUID().toString().replace("-", "").toLowerCase().trim());
  }
}
