package com.didan.forum.notifications.exception;

import com.didan.forum.notifications.dto.Status;
import com.didan.forum.notifications.dto.response.GeneralResponse;
import com.didan.forum.notifications.dto.response.GeneralResponse;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@ControllerAdvice
@RequiredArgsConstructor
public class GlobalException extends ResponseEntityExceptionHandler {

  @Override
  protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex,
      HttpHeaders headers, HttpStatusCode status, WebRequest request) {
    Map<String, String> validationErrors = new HashMap<>();
    List<ObjectError> validationErrorsList = ex.getBindingResult().getAllErrors();

    validationErrorsList.forEach(error -> {
      String fieldName = ((FieldError) error).getField();
      String errorMessage = error.getDefaultMessage();
      validationErrors.put(fieldName, errorMessage);
    });
    Status statusDto = new Status(request.getDescription(false), HttpStatus.BAD_REQUEST.value(),
        ex.getMessage(),
        LocalDateTime.now());
    return new ResponseEntity<>(
        new GeneralResponse<Object>(
            statusDto,
            validationErrors
        ), HttpStatus.BAD_REQUEST);
  }

  @ExceptionHandler(Exception.class)
  public final ResponseEntity<GeneralResponse<Void>> handleAllExceptions(Exception ex,
      WebRequest request) {
    Status statusDto = new Status(request.getDescription(false),
        HttpStatus.INTERNAL_SERVER_ERROR.value(),
        ex.getMessage(),
        LocalDateTime.now());
    return new ResponseEntity<>(
        new GeneralResponse<>(
            statusDto,
            null
        ), HttpStatus.INTERNAL_SERVER_ERROR);
  }

  @ExceptionHandler(ResourceAlreadyExistException.class)
  public final ResponseEntity<GeneralResponse<Void>> handleUserAlreadyExistException(
      ResourceAlreadyExistException ex, WebRequest request) {
    Status statusDto = new Status(request.getDescription(false), HttpStatus.CONFLICT.value(),
        ex.getMessage(),
        LocalDateTime.now());

    return new ResponseEntity<>(
        new GeneralResponse<>(
            statusDto,
            null
        ), HttpStatus.CONFLICT);
  }

  @ExceptionHandler(ResourceNotFoundException.class)
  public final ResponseEntity<GeneralResponse<Void>> handleResourceNotFoundException(
      ResourceNotFoundException ex, WebRequest request) {
    Status statusDto = new Status(request.getDescription(false), HttpStatus.NOT_FOUND.value(),
        ex.getMessage(),
        LocalDateTime.now());
    return new ResponseEntity<>(
        new GeneralResponse<>(statusDto, null), HttpStatus.NOT_FOUND);
  }

  @ExceptionHandler(ErrorActionException.class)
  public final ResponseEntity<GeneralResponse<Void>> handleActionException(
      ErrorActionException ex, WebRequest request) {
    Status statusDto = new Status(request.getDescription(false), HttpStatus.BAD_REQUEST.value(),
        ex.getMessage(),
        LocalDateTime.now());
    return new ResponseEntity<>(
        new GeneralResponse<>(statusDto, null), HttpStatus.BAD_REQUEST);
  }
}
