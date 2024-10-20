package com.didan.forum.users.service.resttemplate;

import com.didan.forum.users.exception.ResourceNotFoundException;
import com.didan.forum.users.service.IRestTemplateService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;

@Service
@Slf4j
@RequiredArgsConstructor
public class RestTemplateServiceImpl implements IRestTemplateService {

  private final RestTemplate restTemplate;

  @Override
  public <T> ResponseEntity<T> process(HttpMethod method, String url, HttpHeaders headers,
      Object requestBody, Class<T> responseType) {
    if (headers == null) { // Nếu không có Header thì tạo mới
      headers = new HttpHeaders(); // Tạo mới Header
      headers.put("Content-Type", List.of("application/json")); // Thêm Content-Type vào Header
      headers.put("Accept", List.of("application/json")); // Thêm Accept vào Header
    }
    try { // Thực hiện gọi API
      // Gọi API, sử dụng hàm exchange của
      // RestTemplate
      return restTemplate.exchange(url, method,
          new HttpEntity<>(requestBody, headers), responseType); // Trả về kết quả
    } catch (HttpClientErrorException | HttpServerErrorException ex) { // Bắt exception khi gọi API
      throw new ResourceNotFoundException(ex.getMessage()); // Ném ra exception ResourceNotFound
    } catch (ResourceAccessException ex) { // Bắt exception khi kết nối bị timeout
      log.error("Connection timeout"); // Log lỗi
      throw new ResourceNotFoundException(ex.getMessage()); // Ném ra exception ResourceNotFound
    }
  }

  @Override
  public <T> ResponseEntity<T> processWithParameterizedType(HttpMethod method, String url,
      HttpHeaders headers, Object requestBody, ParameterizedTypeReference<T> typeReference) {
    if (headers == null) { // Nếu không có Header thì tạo mới
      headers = new HttpHeaders();
      headers.put("Content-Type", List.of("application/json"));
      headers.put("Accept", List.of("application/json"));
    }
    try { // Thực hiện gọi API
      // Gọi API, sử dụng hàm exchange của RestTemplate
      return restTemplate.exchange(url, method,
          new HttpEntity<>(requestBody, headers),
          typeReference); // Trả về kết quả
    } catch (HttpClientErrorException | HttpServerErrorException ex) { // Bắt exception khi gọi API
      throw new ResourceNotFoundException(ex.getMessage()); // Ném ra exception ResourceNotFound
    } catch (ResourceAccessException ex) { // Bắt exception khi kết nối bị timeout
      log.error("Connection timeout"); // Log lỗi
      throw new ResourceNotFoundException(ex.getMessage()); // Ném ra exception ResourceNotFound
    }
  }
}
