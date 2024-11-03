package com.didan.forum.notifications.filter;

import com.didan.forum.notifications.service.VerifyUserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Set;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

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
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        return;
      }
      log.info("Verify userId: {}", userId);
      if (!Boolean.TRUE.equals(verifyUserService.verifyUser(userId))) {
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        return;
      }
    }
    filterChain.doFilter(request, response);
  }
}
