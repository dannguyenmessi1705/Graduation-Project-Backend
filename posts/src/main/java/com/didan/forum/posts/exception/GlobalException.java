package com.didan.forum.posts.exception;


import com.didan.forum.posts.config.locale.Translator;
import com.didan.forum.posts.dto.Status;
import com.didan.forum.posts.dto.response.GeneralResponse;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.client.ResponseErrorHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;
import org.springframework.web.servlet.resource.NoResourceFoundException;

@ControllerAdvice
public class GlobalException extends ResponseEntityExceptionHandler implements
    ResponseErrorHandler {

  @Override
  protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex,
      HttpHeaders headers, HttpStatusCode status, WebRequest request) {
    Map<String, String> validationErrors = new HashMap<>();
    List<ObjectError> validationErrorsList = ex.getBindingResult().getAllErrors();

    validationErrorsList.forEach(error -> {
      String fieldName = ((FieldError) error).getField();
      String errorMessage = Translator.toLocale(error.getDefaultMessage());
      validationErrors.put(fieldName, errorMessage);
    });
    Status statusDto = new Status(request.getDescription(false), HttpStatus.BAD_REQUEST.value(),
        "Input validation error",
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

  @Override
  protected ResponseEntity<Object> handleNoHandlerFoundException(NoHandlerFoundException ex,
      HttpHeaders headers, HttpStatusCode status, WebRequest request) {
    Status statusDto = new Status(request.getDescription(false),
        HttpStatus.NOT_FOUND.value(),
        ex.getMessage(),
        LocalDateTime.now());
    return new ResponseEntity<>(
        new GeneralResponse<>(
            statusDto,
            null
        ), HttpStatus.NOT_FOUND);
  }

  @Override
  protected ResponseEntity<Object> handleNoResourceFoundException(NoResourceFoundException ex,
      HttpHeaders headers, HttpStatusCode status, WebRequest request) {
    Status statusDto = new Status(request.getDescription(false),
        HttpStatus.NOT_FOUND.value(),
        ex.getMessage(),
        LocalDateTime.now());
    return new ResponseEntity<>(
        new GeneralResponse<>(
            statusDto,
            null
        ), HttpStatus.NOT_FOUND);
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

  @Override
  public boolean hasError(ClientHttpResponse response) throws IOException {
    HttpStatusCode status = response.getStatusCode();
    return status.is4xxClientError() || status.is5xxServerError();
  }

  @Override
  public void handleError(ClientHttpResponse response) throws IOException {
    String responseAsString = toString(response.getBody());
    throw new CustomException(responseAsString);
  }

  @Override
  public void handleError(URI url, HttpMethod method, ClientHttpResponse response)
      throws IOException {
    String responseAsString = toString(response.getBody());
    throw new CustomException(responseAsString);
  }

  String toString(InputStream inputStream) {
    Scanner s = new Scanner(inputStream).useDelimiter("\\A");
    return s.hasNext() ? s.next() : "";
  }
}
