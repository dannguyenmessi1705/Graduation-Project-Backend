package com.didan.forum.chats.utils;

public class SubstringURIUtils {
  public static String cutURI(String uri) {
    return uri.substring(uri.indexOf("=") + 1);
  }
}