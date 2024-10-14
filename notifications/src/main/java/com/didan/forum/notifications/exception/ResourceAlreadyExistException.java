package com.didan.forum.notifications.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.CONFLICT)
public class ResourceAlreadyExistException extends RuntimeException {
  public ResourceAlreadyExistException(String message) {
    super(message);
  }
}
