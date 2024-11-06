package com.didan.forum.comments.filter;

import com.didan.forum.comments.constant.TrackingConstant;
import com.didan.forum.comments.dto.Status;
import com.didan.forum.comments.dto.response.GeneralResponse;
import com.didan.forum.comments.entity.LogSystemEntity;
import com.didan.forum.comments.utils.LogUtils;
import com.didan.forum.comments.utils.ObjectMapperUtils;
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
import org.springframework.http.HttpStatusCode;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.util.ContentCachingResponseWrapper;

@Configuration
@Slf4j
@Order(1)
public class LogFilter extends OncePerRequestFilter {

  @Value("${spring.application.name}")
  private String applicationName;

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
      FilterChain filterChain) throws ServletException, IOException {
    String uri = request.getRequestURI();
    if (LogUtils.isIgnoreUri(uri)) {
      filterChain.doFilter(request, response);
      return;
    }

    long time = System.currentTimeMillis();
    String correlationId = generateCorrelationId(request.getHeader(TrackingConstant.CORRELATION_ID.getHeaderKey()));
    response.setHeader(TrackingConstant.CORRELATION_ID.getHeaderKey(), correlationId);
    response.setHeader(TrackingConstant.TRACE_ID.getHeaderKey(), MDC.get(TrackingConstant.TRACE_ID.getHeaderKey()));
    response.setHeader(TrackingConstant.SPAN_ID.getHeaderKey(), MDC.get(TrackingConstant.SPAN_ID.getHeaderKey()));

    request = new RequestWrapper(request);

    ContentCachingResponseWrapper responseWrapper = new ContentCachingResponseWrapper(response);
    String method = request.getMethod();

    filterChain.doFilter(request, responseWrapper);

    if (!uri.startsWith("/actuator") && !uri.startsWith("/swagger") && !uri.startsWith("/api-docs") && !uri.startsWith("/websocket")) {
      String responseBody = new String(responseWrapper.getContentAsByteArray());
      Status status = getApplicationErrorCode(uri, responseBody);
      if (status != null) {
        String errorType = getErrorType(status);
        long now = System.currentTimeMillis();
        long duration;
        String durationString = MDC.get(TrackingConstant.DURATION.getHeaderKey());
        duration = now - time;
        if (StringUtils.hasText(durationString)) {
          try {
            duration = Long.parseLong(durationString);
          } catch (Exception e) {
            log.error("Error while parsing duration", e);
          }
        }
        LogSystemEntity logSystemEntity = LogSystemEntity.builder()
            .applicationCode(applicationName)
            .requestID(MDC.get(TrackingConstant.X_REQUEST_ID.getHeaderKey()))
            .sessionID(MDC.get(TrackingConstant.TRACE_ID.getHeaderKey()))
            .requestContent(LogUtils.hideSensitiveData(((RequestWrapper) request).getBody()))
            .responseContent(LogUtils.hideSensitiveData(responseBody))
            .startTime(String.valueOf(time))
            .endTime(String.valueOf(now))
            .duration(String.valueOf(duration))
            .username(MDC.get(TrackingConstant.X_USER_ID.getHeaderKey()))
            .statusCode(String.valueOf(status.getStatusCode()))
            .message(status.getMessage())
            .requestStatus(errorType)
            .actionName(method)
            .apiPath(status.getApiPath())
            .userAgent(MDC.get(TrackingConstant.USER_AGENT.getHeaderKey()))
            .spanId(MDC.get(TrackingConstant.SPAN_ID.getHeaderKey()))
            .correlationId(MDC.get(TrackingConstant.CORRELATION_ID.getHeaderKey()))
            .build();

        log.info("STANDARD_LOG: {}", ObjectMapperUtils.toJson(logSystemEntity));
        log.info("REPORT|{}|{}|{}|{}|{}|{}|{}|{}",
            applicationName,
            method,
            uri,
            response.getStatus(),
            errorType,
            correlationId,
            System.currentTimeMillis() - time,
            status.getMessage()
        );
      }
    }
    responseWrapper.copyBodyToResponse();

    log.info("{}: {} ms", request.getRequestURI(), System.currentTimeMillis() - time);
  }

  public String generateCorrelationId(String correlationId) {
    String correlation = StringUtils.hasText(correlationId) ? correlationId : applicationName + "-" + UUID.randomUUID().toString().replaceAll("-", "");
    MDC.put(TrackingConstant.CORRELATION_ID.getHeaderKey(), correlation);
    return correlation;
  }

  private Status getApplicationErrorCode(String uri, String responseBody) {
    try {
      if (!StringUtils.hasText(responseBody)) {
        return null;
      } else {
        return ObjectMapperUtils.fromJson(responseBody, GeneralResponse.class).getStatus();
      }
    } catch (Exception e) {
      log.error("Error while getting application error code", e);
      return null;
    }
  }

  private String getErrorType(Status status) {
    if (HttpStatusCode.valueOf(status.getStatusCode()).is2xxSuccessful()) {
      return "Success";
    } else if (HttpStatusCode.valueOf(status.getStatusCode()).is4xxClientError()) {
      return "ClientError";
    } else if (HttpStatusCode.valueOf(status.getStatusCode()).is5xxServerError()) {
      return "ServerError";
    } else {
      return "UnknownError";
    }
  }
}
