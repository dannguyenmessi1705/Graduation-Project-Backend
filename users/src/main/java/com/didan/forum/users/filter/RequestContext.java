package com.didan.forum.users.filter;

import jakarta.servlet.http.HttpServletRequest;

public class RequestContext {
  private static final ThreadLocal<HttpServletRequest> request = new ThreadLocal<>();

  public static void setRequest(HttpServletRequest request) {
    RequestContext.request.set(request);
  }

  public static HttpServletRequest getRequest() {
    return RequestContext.request.get();
  }

  public static void clear() {
    RequestContext.request.remove();
  }
}
