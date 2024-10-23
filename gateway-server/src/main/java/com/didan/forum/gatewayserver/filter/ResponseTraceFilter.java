package com.didan.forum.gatewayserver.filter;

import com.didan.forum.gatewayserver.constant.TrackingConstant;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import reactor.core.publisher.Mono;

@Configuration
@Slf4j
@RequiredArgsConstructor
public class ResponseTraceFilter {
  private final FilterUtils filterUtils;

  @Bean
  public GlobalFilter globalFilter() {
    return (exchange, chain) -> chain.filter(exchange).then(Mono.fromRunnable(() -> {
      HttpHeaders httpHeaders = exchange.getRequest().getHeaders();
      String traceId = filterUtils.getTraceId(httpHeaders);
      if (!(exchange.getResponse().getHeaders().containsKey(TrackingConstant.TRACE_ID.getHeaderKey()))) {
        log.debug("Updating response with the correlation id: {}.", traceId);
        exchange.getResponse().getHeaders().add(TrackingConstant.TRACE_ID.getHeaderKey(), traceId);
      }
    }));
  }
}
