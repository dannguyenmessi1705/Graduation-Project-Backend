package com.didan.forum.notifications.utils;

public class SubstringURIUtils {
  public static String cutURI(String uri) {
    return uri.substring(uri.indexOf("=") + 1);
  }
}
