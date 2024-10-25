package com.didan.forum.gatewayserver.controller.impl;

import com.didan.forum.gatewayserver.controller.api.FallBackController;
import com.didan.forum.gatewayserver.dto.Status;
import com.didan.forum.gatewayserver.dto.response.GeneralResponse;
import java.time.LocalDateTime;
import java.util.Locale;
import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
public class FallBackControllerImpl implements FallBackController {

  private final MessageSource messageSource;

  @Override
  public Mono<GeneralResponse<Void>> contactSupport() {
    Locale locale = LocaleContextHolder.getLocale();
    Status statusDto = new Status("/forum/contact-support", 503,
        messageSource.getMessage("service.unavailable", null, locale), LocalDateTime.now().toString());
    return Mono.just(new GeneralResponse<>(
        statusDto,
        null));
  }

}
