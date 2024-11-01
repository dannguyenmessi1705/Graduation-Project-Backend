package com.didan.forum.users.filter;

import com.didan.forum.users.repository.user.UserRepository;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Set;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Qualifier;
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
  private final UserRepository userRepository;

  @Value("${private.route}")
  private Set<String> privateRoutes;

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
      @NotNull FilterChain filterChain) throws ServletException, IOException {
    log.info("SimpleSecurityFilter: doFilterInternal");
    String pathUrl = request.getRequestURI();
    if (privateRoutes.stream().anyMatch(pathUrl::contains)) {
      String userId = request.getHeader("X-User-Id");
      log.info("Verify userId: {}", userId);
      if (!StringUtils.hasText(userId) || !userRepository.existsById(userId)) {
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        return;
      }
    }
    filterChain.doFilter(request, response);
  }
}
