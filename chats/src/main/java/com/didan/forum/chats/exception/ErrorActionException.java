package com.didan.forum.chats.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class ErrorActionException extends RuntimeException {
  public ErrorActionException(String message) {
    super(message);
  }
}
