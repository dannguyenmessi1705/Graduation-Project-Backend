package com.didan.forum.users.config;

import com.didan.forum.users.exception.GlobalException;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.ResponseErrorHandler;
import org.springframework.web.client.RestTemplate;

@Configuration
@Slf4j
@Data
public class RestTemplateConfig {

  @Bean
  public RestTemplate clientRequestRestTemplate() {
    HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory(); // Tạo một factory để cấu hình RestTemplate
    factory.setConnectTimeout(5000); // Thời gian kết nối tối đa là 5s
    factory.setConnectionRequestTimeout(5000); // Thời gian chờ kết nối tối đa là 5s
    RestTemplate restTemplate = new RestTemplate(
        factory); // Tạo RestTemplate với factory đã cấu hình
    restTemplate.setErrorHandler(new GlobalException()); // Xử lý exception khi gọi API (nếu có
    // định nghĩa các
    // Error Handler) đã trình bày ở bài 15, mục #4.4
    return restTemplate; // Trả về RestTemplate đã cấu hình
  }
}