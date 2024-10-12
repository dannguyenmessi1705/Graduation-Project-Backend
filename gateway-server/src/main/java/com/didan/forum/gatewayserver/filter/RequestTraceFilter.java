package com.didan.forum.gatewayserver.filter;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Order(1)
@Component
@Slf4j
@RequiredArgsConstructor
public class RequestTraceFilter implements GlobalFilter {
  private final FilterUtils filterUtils;

  @Override
  public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
    HttpHeaders httpHeaders = exchange.getRequest().getHeaders();
    if (isCorrelationIdPresent(httpHeaders)) {
      log.debug("forum-correlation-id found in tracking filter: {}. ", filterUtils.getCorrelationId(httpHeaders));
    } else {
      String correlationId = generateCorrelationId();
      filterUtils.setCorrelationId(exchange, correlationId);
      log.debug("forum-correlation-id generated in tracking filter: {}.", correlationId);
    }
    return chain.filter(exchange);
  }

  private boolean isCorrelationIdPresent(HttpHeaders httpHeaders) {
    return filterUtils.getCorrelationId(httpHeaders) != null;
  }

  private String generateCorrelationId() {
    return java.util.UUID.randomUUID().toString();
  }
}
