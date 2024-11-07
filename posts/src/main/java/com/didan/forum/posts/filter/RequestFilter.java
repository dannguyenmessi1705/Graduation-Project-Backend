package com.didan.forum.posts.filter;

import com.didan.forum.posts.constant.TrackingConstant;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Locale;
import java.util.UUID;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.ThreadContext;
import org.slf4j.MDC;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpHeaders;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

@Configuration
@Order(0)
@Slf4j
public class RequestFilter extends OncePerRequestFilter {

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
      FilterChain filterChain) throws ServletException, IOException {
    String appVersion = request.getHeader(TrackingConstant.APP_VERSION.getHeaderKey());
    String osVersion = request.getHeader(TrackingConstant.OS_VERSION.getHeaderKey());
    String typeOS = request.getHeader(TrackingConstant.TYPE_OS.getHeaderKey());
    String userAgent = request.getHeader(TrackingConstant.USER_AGENT.getHeaderKey());

    MDC.put(TrackingConstant.APP_VERSION.getHeaderKey(), appVersion);
    MDC.put(TrackingConstant.TYPE_OS.getHeaderKey(), typeOS);
    MDC.put(TrackingConstant.OS_VERSION.getHeaderKey(), osVersion);
    MDC.put(TrackingConstant.USER_AGENT.getHeaderKey(), userAgent);

    String xOriginalForwardFor = request.getHeader(TrackingConstant.X_ORIGINAL_FORWARD_FOR.getHeaderKey());
    String ip = request.getHeader(TrackingConstant.X_FORWARD_FOR.getHeaderKey());
    if (StringUtils.hasText(xOriginalForwardFor)) {
      try {
        ip = xOriginalForwardFor.split(",")[0];
      } catch (Exception e) {
        log.error("Exception when parse IP", e);
      }
    } else {
      String xRealIp = request.getHeader(TrackingConstant.X_REAL_IP.getHeaderKey());
      ip = StringUtils.hasText(xRealIp) ? xRealIp : request.getRemoteAddr();
    }
    MDC.put(TrackingConstant.X_REAL_IP.getHeaderKey(), ip);

    if (!StringUtils.hasText(request.getHeader(HttpHeaders.ACCEPT_LANGUAGE))) {
      LocaleContextHolder.setLocale(Locale.of("en"));
    }

    generateCorrelationIdIfNotExists(request.getHeader(TrackingConstant.X_REQUEST_ID.getHeaderKey()));
    response.setHeader(TrackingConstant.X_REQUEST_ID.getHeaderKey(),
        MDC.get(TrackingConstant.X_REQUEST_ID.getHeaderKey()));

    if (StringUtils.hasText(request.getHeader(TrackingConstant.X_USER_ID.getHeaderKey()))) {
      MDC.put(TrackingConstant.X_USER_ID.getHeaderKey(), request.getHeader(TrackingConstant.X_USER_ID.getHeaderKey()));
    }

    RequestContext.setRequest(request);

    filterChain.doFilter(request, response);

    RequestContext.clear();
    MDC.clear();
  }

  private void generateCorrelationIdIfNotExists(String xRequestId) {
    String requestId = StringUtils.hasText(xRequestId) ? xRequestId : UUID.randomUUID().toString().replace("-", "")
        .toLowerCase();
    MDC.put(TrackingConstant.X_REQUEST_ID.getHeaderKey(), requestId);
  }
}
