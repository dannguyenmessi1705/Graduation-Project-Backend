package com.didan.forum.chats.config.locale;

import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;

public class Translator {
  private static ResourceBundleMessageSource messageSource;

  public static void setMessageSource(ResourceBundleMessageSource messageSource) {
    Translator.messageSource = messageSource;
  }

  public static String toLocale(String messageCode, String... params) {
    return messageSource.getMessage(messageCode, params, LocaleContextHolder.getLocale());
  }
}
