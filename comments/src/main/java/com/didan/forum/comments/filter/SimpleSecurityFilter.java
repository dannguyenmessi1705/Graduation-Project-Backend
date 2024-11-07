package com.didan.forum.comments.filter;

import com.didan.forum.comments.dto.Status;
import com.didan.forum.comments.dto.response.GeneralResponse;
import com.didan.forum.comments.service.VerifyUserService;
import com.didan.forum.comments.service.client.UsersFeignClient;
import com.didan.forum.comments.utils.LogUtils;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.Set;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.util.ContentCachingResponseWrapper;

@Configuration
@RequiredArgsConstructor
@Slf4j
@Order(3)
public class SimpleSecurityFilter extends OncePerRequestFilter {
  @Value("${private.route}")
  private Set<String> privateRoutes;

  private final VerifyUserService verifyUserService;

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
      @NotNull FilterChain filterChain) throws ServletException, IOException {
    log.info("SimpleSecurityFilter: doFilterInternal");
    String pathUrl = request.getRequestURI();
    if (privateRoutes.stream().anyMatch(pathUrl::contains)) {
      String userId = request.getHeader("X-User-Id");
      if (!StringUtils.hasText(userId)) {
        LogUtils.sendError(new ContentCachingResponseWrapper(response),
            new Status(request.getRequestURI(), HttpStatus.FORBIDDEN.value(), "Unauthorized", LocalDateTime.now()));
        return;
      }
      log.info("Verify userId: {}", userId);
      if (!Boolean.TRUE.equals(verifyUserService.verifyUser(userId))) {
        LogUtils.sendError(new ContentCachingResponseWrapper(response),
            new Status(request.getRequestURI(), HttpStatus.FORBIDDEN.value(), "Unauthorized", LocalDateTime.now()));
        return;
      }
    }
    filterChain.doFilter(request, response);
  }
}
