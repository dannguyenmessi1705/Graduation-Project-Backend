package com.didan.forum.comments.filter;

import com.didan.forum.comments.filter.cachehttp.CachedBodyHttpServletRequest;
import com.didan.forum.comments.utils.LogUtils;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.util.ContentCachingRequestWrapper;
import org.springframework.web.util.ContentCachingResponseWrapper;

@Configuration
@Slf4j
@Order(1)
@ConditionalOnProperty(value = "app.log.request.extended.enabled", havingValue = "true")
public class RequestHttpFilterExtended extends OncePerRequestFilter {

  Map<String, String> replaceCharsError = new HashMap<>();
  @Value("#{'${app.log.request.ignoreHeaders}'.split(',')}")
  private List<String> ignoredHeaders;

  public RequestHttpFilterExtended() {
    replaceCharsError.put("\u0000", "");
  }

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
    StringBuilder str = new StringBuilder();

    try {
      String uri = request.getRequestURI();
      if (LogUtils.isIgnoreUri(uri)) {
        filterChain.doFilter(request, response);
        return;
      }

      ContentCachingResponseWrapper responseWrapper = new ContentCachingResponseWrapper(response);
      CachedBodyHttpServletRequest cachedBodyHttpServletRequest = new CachedBodyHttpServletRequest(new ContentCachingRequestWrapper(request));

      // request
      Map<String, String> headers = cachedBodyHttpServletRequest.getHeaders();
      for (String ignoredHeader : ignoredHeaders) {
        headers.replace(ignoredHeader, "***");
      }

      str.append("Request = ").append(" \n")
          .append("Request to: ").append(getFullURL(cachedBodyHttpServletRequest)).append(" \n")
          .append("Method    : ").append(cachedBodyHttpServletRequest.getMethod()).append(" \n")
          .append("Header    : ").append(headers).append(" \n")
          .append("Body      : ").append(replaceChars(new String(cachedBodyHttpServletRequest.getCachedBody(), StandardCharsets.UTF_8))).append(" \n")
          .append(" \n");

      filterChain.doFilter(cachedBodyHttpServletRequest, responseWrapper);

      // response
      str.append("Response = ").append(" \n")
          .append("Status code: ").append(responseWrapper.getStatus()).append(" \n")
          .append("Headers    : ").append(getHeaders(responseWrapper)).append(" \n")
          .append("Body       : ").append(getBodyResponse(responseWrapper)).append(" \n");
      responseWrapper.copyBodyToResponse();
    } catch (Exception e) {
      log.error(e.getMessage(), e);
      str.insert(0, "Error parsing response. Parseable data: \n");
    } finally {
      if (!StringUtils.isEmpty(str.toString())) {
        log.info(str.toString());
      }
    }
  }

  public String getBodyResponse(ContentCachingResponseWrapper responseWrapper) {
    return LogUtils.hideSensitiveData(new String(responseWrapper.getContentAsByteArray()));
  }

  public Map<String, String> getHeaders(HttpServletResponse response) {
    Map<String, String> map = new HashMap<>();
    Collection<String> headersName = response.getHeaderNames();
    for (String s : headersName) {
      map.put(s, response.getHeader(s));
    }

    return map;
  }

  public String getFullURL(HttpServletRequest request) {
    StringBuilder requestURL = new StringBuilder(request.getRequestURL().toString());
    String queryString = request.getQueryString();

    if (queryString == null) {
      return requestURL.toString();
    } else {
      return requestURL.append('?').append(queryString).toString();
    }
  }

  public String replaceChars(String str) {
    for (Map.Entry<String, String> entry : replaceCharsError.entrySet()) {
      str = str.replace(entry.getKey(), entry.getValue());
    }
    return str;
  }
}
