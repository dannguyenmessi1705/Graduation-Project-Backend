package com.didan.forum.gatewayserver.exception;

import com.didan.forum.gatewayserver.dto.Status;
import com.didan.forum.gatewayserver.dto.response.GeneralResponse;
import java.time.LocalDateTime;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.reactive.result.method.annotation.ResponseEntityExceptionHandler;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@ControllerAdvice
public class GlobalException extends ResponseEntityExceptionHandler  {

  @Override
  protected Mono<ResponseEntity<Object>> handleResponseStatusException(ResponseStatusException ex,
      HttpHeaders headers, HttpStatusCode status, ServerWebExchange exchange) {
    Status statusResponse = new Status(exchange.getRequest().getURI().getPath(), status.value(),
        ex.getMessage(), LocalDateTime.now().toString());
    return Mono.just(new ResponseEntity<>(new GeneralResponse<>(statusResponse, null), status));
  }

  @Override
  protected Mono<ResponseEntity<Object>> handleExceptionInternal(Exception ex, Object body,
      HttpHeaders headers, HttpStatusCode status, ServerWebExchange exchange) {
    Status statusResponse = new Status(exchange.getRequest().getURI().getPath(), status.value(),
        ex.getMessage(), LocalDateTime.now().toString());
    return Mono.just(new ResponseEntity<>(new GeneralResponse<>(statusResponse, null), status));
  }
}
