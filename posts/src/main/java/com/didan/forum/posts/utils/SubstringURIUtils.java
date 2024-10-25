package com.didan.forum.posts.utils;

public class SubstringURIUtils {
  public static String cutURI(String uri) {
    return uri.substring(uri.indexOf("=") + 1);
  }
}
