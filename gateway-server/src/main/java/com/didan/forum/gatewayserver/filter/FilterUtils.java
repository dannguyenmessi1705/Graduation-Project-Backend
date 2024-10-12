package com.didan.forum.gatewayserver.filter;

import java.util.List;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;

@Component
public class FilterUtils {

  public static final String CORRELATION_ID = "forum-correlation-id";

  public String getCorrelationId(HttpHeaders httpHeaders) {
    if (httpHeaders.get(CORRELATION_ID) != null) {
      List<String> requestHeaders = httpHeaders.get(CORRELATION_ID);
      return requestHeaders.stream().findFirst().get();
    } else {
      return null;
    }
  }

  public ServerWebExchange setRequestHeader(ServerWebExchange exchange, String key, String value) {
    return exchange.mutate().request(exchange.getRequest().mutate().header(key, value).build())
        .build();
  }

  public ServerWebExchange setCorrelationId(ServerWebExchange exchange, String correlationId) {
    return setRequestHeader(exchange, CORRELATION_ID, correlationId);
  }

}
