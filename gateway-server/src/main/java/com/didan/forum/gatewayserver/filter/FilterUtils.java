package com.didan.forum.gatewayserver.filter;

import com.didan.forum.gatewayserver.constant.TrackingConstant;
import java.util.List;
import org.slf4j.MDC;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;

@Component
public class FilterUtils {

  public String getTraceId(HttpHeaders httpHeaders) {
    if (httpHeaders.get(TrackingConstant.TRACE_ID.getHeaderKey()) != null) {
      List<String> requestHeaders = httpHeaders.get(TrackingConstant.TRACE_ID.getHeaderKey());
      assert requestHeaders != null;
      return requestHeaders.stream().findFirst().isPresent() ? requestHeaders.stream().findFirst().get() : null;
    } else {
      return null;
    }
  }

  public String getxUserId(HttpHeaders httpHeaders) {
    if (httpHeaders.get(TrackingConstant.X_USER_ID.getHeaderKey()) != null) {
      List<String> requestHeaders = httpHeaders.get(TrackingConstant.X_USER_ID.getHeaderKey());
      assert requestHeaders != null;
      return requestHeaders.stream().findFirst().isPresent() ? requestHeaders.stream().findFirst().get() : null;
    } else {
      return null;
    }
  }

  public ServerWebExchange setRequestHeader(ServerWebExchange exchange, String key, String value) {
    return exchange.mutate().request(exchange.getRequest().mutate().header(key, value).build())
        .build();
  }

  public ServerWebExchange setTraceId(ServerWebExchange exchange, String correlationId) {
    MDC.put(TrackingConstant.TRACE_ID.getHeaderKey(), correlationId);
    return setRequestHeader(exchange, TrackingConstant.TRACE_ID.getHeaderKey(), correlationId);
  }

  public ServerWebExchange setxUserId(ServerWebExchange exchange, String xUserId) {
    return setRequestHeader(exchange, TrackingConstant.X_USER_ID.getHeaderKey(), xUserId);
  }

}
