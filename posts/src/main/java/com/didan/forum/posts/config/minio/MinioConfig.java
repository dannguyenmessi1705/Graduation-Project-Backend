package com.didan.forum.posts.config.minio;

import io.minio.MinioClient;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;

@Configuration
@Lazy
@Data
@Slf4j
@ConfigurationProperties(prefix = "minio.root")
public class MinioConfig {
  private String endpoint;
  private String user;
  private String password;

  @Bean
  public MinioClient minioClient() {
    return MinioClient.builder()
        .endpoint(endpoint)
        .credentials(user, password)
        .build();
  }
}
