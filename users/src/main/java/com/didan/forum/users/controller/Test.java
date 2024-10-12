package com.didan.forum.users.controller;

import com.didan.forum.users.dto.Status;
import com.didan.forum.users.dto.response.GeneralResponse;
import java.time.LocalDateTime;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Test {
  @GetMapping("/test")
  public ResponseEntity<GeneralResponse<String>> test() {
    Status status = new Status("/test", 200, "Hello World", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, "Hello World"), HttpStatus.OK);
  }
}
