package com.didan.forum.users.config.locale;

import jakarta.annotation.PostConstruct;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Component;

@Component
public class StaticTranslatorInitializer {
  private final ResourceBundleMessageSource resourceBundleMessageSource;

  public StaticTranslatorInitializer(ResourceBundleMessageSource resourceBundleMessageSource) {
    this.resourceBundleMessageSource = resourceBundleMessageSource;
  }

  @PostConstruct
  public void init() {
    Translator.setMessageSource(resourceBundleMessageSource);
  }
}
