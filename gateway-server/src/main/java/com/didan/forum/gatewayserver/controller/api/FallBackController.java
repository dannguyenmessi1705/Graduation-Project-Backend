package com.didan.forum.gatewayserver.controller.api;

import com.didan.forum.gatewayserver.dto.response.GeneralResponse;
import org.springframework.web.bind.annotation.GetMapping;
import reactor.core.publisher.Mono;

public interface FallBackController {
  @GetMapping("/contact-support")
  Mono<GeneralResponse<Void>> contactSupport();
}
