package com.didan.forum.chats.filter;

import jakarta.servlet.http.HttpServletRequest;

public class RequestContext {
  private RequestContext() {}

  private static final ThreadLocal<HttpServletRequest> currentRequest = new ThreadLocal<>();

  public static void setRequest(HttpServletRequest request) {
    currentRequest.set(request);
  }

  public static HttpServletRequest getRequest() {
    return currentRequest.get();
  }

  public static void clear() {
    currentRequest.remove();
  }
}
