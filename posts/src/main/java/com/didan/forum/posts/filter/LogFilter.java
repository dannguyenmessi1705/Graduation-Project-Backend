package com.didan.forum.posts.filter;

import com.didan.forum.posts.constant.TrackingConstant;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

@Configuration
@Slf4j
@Order(2)
public class LogFilter extends OncePerRequestFilter {
  @Value("${spring.application.name}")
  private String applicationName;

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
      FilterChain filterChain) throws ServletException, IOException {
    generateTraceIdIfNotExists(request.getHeader(TrackingConstant.TRACE_ID.getHeaderKey()));
    generateSpanId();
    response.setHeader(TrackingConstant.TRACE_ID.getHeaderKey(),
        MDC.get(TrackingConstant.TRACE_ID.getHeaderKey()));
    response.setHeader(TrackingConstant.SPAN_ID.getHeaderKey(),
        MDC.get(TrackingConstant.SPAN_ID.getHeaderKey()));
    filterChain.doFilter(request, response);
    log.info("Request: {} {} {} {}",
        request.getMethod(),
        request.getRequestURI(),
        response.getStatus(),
        MDC.get(TrackingConstant.TRACE_ID.getHeaderKey()));
    MDC.clear();
  }

  private void generateTraceIdIfNotExists(String xTraceId) {
    log.info("xTraceId: {}", xTraceId);
    String traceId = StringUtils.hasText(xTraceId) ? xTraceId : String.format("%s-%s",
        applicationName,
        UUID.randomUUID().toString());
    MDC.put(TrackingConstant.TRACE_ID.getHeaderKey(), traceId);
  }

  public void generateSpanId() {
    MDC.put(TrackingConstant.SPAN_ID.getHeaderKey(), String.format("%s-%s",
        applicationName,
        UUID.randomUUID().toString().replace("-", "").toLowerCase().trim()));
  }
}
