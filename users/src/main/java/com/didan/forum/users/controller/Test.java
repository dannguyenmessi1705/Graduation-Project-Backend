package com.didan.forum.users.controller;

import com.didan.forum.users.dto.Status;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.config.locale.Translator;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class Test {
  private final MessageSource messageSource;
  @GetMapping("/test")
  public ResponseEntity<GeneralResponse<String>> test() {
    String s = Translator.toLocale("method.argument.invalid", "");
    Status status = new Status("/test", 200, s, LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, "Hello World"), HttpStatus.OK);
  }
}
