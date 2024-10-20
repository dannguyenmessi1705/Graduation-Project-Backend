package com.didan.forum.users.service;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;

public interface IRestTemplateService {

  <T> ResponseEntity<T> process(HttpMethod method, String url, HttpHeaders headers,
      Object requestBody, Class<T> responseType);

  <T> ResponseEntity<T> processWithParameterizedType(HttpMethod method, String url,
      HttpHeaders headers, Object requestBody, ParameterizedTypeReference<T> typeReference);
}
