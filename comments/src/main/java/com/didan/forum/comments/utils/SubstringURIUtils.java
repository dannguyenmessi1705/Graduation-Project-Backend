package com.didan.forum.comments.utils;

public class SubstringURIUtils {
  public static String cutURI(String uri) {
    return uri.substring(uri.indexOf("=") + 1);
  }
}
