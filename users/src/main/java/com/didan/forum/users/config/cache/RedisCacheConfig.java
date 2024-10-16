package com.didan.forum.users.config.cache;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.cache.annotation.CachingConfigurer;
import org.springframework.cache.interceptor.CacheErrorHandler;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.RedisPassword;
import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.util.StringUtils;

@Configuration
@Slf4j
@ConditionalOnProperty(value = "app.cache.redis.enabled", havingValue = "true")
public class RedisCacheConfig implements CachingConfigurer {

  @Value("${spring.application.name}") // Đọc giá trị của property spring.application.name
  private String appName;

  @Value("${app.cache.redis.host}")
  private String host;

  @Value("${app.cache.redis.port}")
  private int port;

  @Value("${app.cache.redis.password}")
  private String password;

  @Value("${app.cache.redis.timeoutSeconds}")
  private int timeoutSeconds;

  @Value("${app.cache.redis.maxPoolSize}")
  private int maxPoolSize;

  @Value("${app.cache.redis.maxIdle}")
  private int maxIdle;

  @Value("${app.cache.redis.minIdle}")
  private int minIdle;

  @Bean
  public RedisConnectionFactory redisConnectionFactory() {
    log.info("Redis configuration enabled. With cache timeout " + timeoutSeconds + " seconds.");
    return createStandaloneFactory();
  }

  private RedisConnectionFactory createStandaloneFactory() {
    log.info("Creating Redis Standalone Connection Factory");
    RedisStandaloneConfiguration redisStandaloneConfiguration = new RedisStandaloneConfiguration();
    redisStandaloneConfiguration.setHostName(host);
    redisStandaloneConfiguration.setPort(port);
    if (StringUtils.hasText(password)) {
      redisStandaloneConfiguration.setPassword(RedisPassword.of(password));
    }
    return new LettuceConnectionFactory(redisStandaloneConfiguration);
  }

  @Bean
  public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory cf) {
    RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
    redisTemplate.setKeySerializer(RedisSerializer.string());
    redisTemplate.setHashKeySerializer(RedisSerializer.string());
    redisTemplate.setConnectionFactory(cf);
    return redisTemplate;
  }

  // Tạo custom CacheErrorHandler để xử lý exception khi thao tác với cache
  @Override
  public CacheErrorHandler errorHandler() {
    return new RedisCacheErrorHandle();
  }

}
