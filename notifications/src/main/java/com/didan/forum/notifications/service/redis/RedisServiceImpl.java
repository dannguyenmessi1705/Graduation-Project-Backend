package com.didan.forum.notifications.service.redis;

import com.didan.forum.notifications.service.IRedisService;
import com.didan.forum.notifications.utils.ObjectMapperUtils;
import com.fasterxml.jackson.core.type.TypeReference;
import java.util.concurrent.TimeUnit;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
@RequiredArgsConstructor
@Lazy
@Slf4j
public class RedisServiceImpl implements IRedisService {

  private final RedisTemplate<String, Object> redisTemplate;

  @Value("${spring.application.name}")
  private String appName;

  @Override
  public <T> void setCache(String cacheName, String key, T value) {
    setCache(cacheName, key, value, -1);
  }

  @Override
  public <T> void setCache(String cacheName, String key, T value, long expireTime) {
    String keyGen = keyGen(cacheName, key);
    try {
      String valueStr = ObjectMapperUtils.toJson(value);
      log.info("Redis set cache: cacheName={}, key={}, value={}, expireTime={}", cacheName, keyGen,
          valueStr, expireTime);
      redisTemplate.opsForValue().set(keyGen, valueStr);
      if (expireTime != -1) {
        redisTemplate.expire(keyGen, expireTime, TimeUnit.SECONDS);
      }
    } catch (Exception ex) {
      log.error("Error when set cache: cacheName={}, key={}, value={}, expireTime={}", cacheName,
          key, ObjectMapperUtils.toJson(value), expireTime, ex);
    }
  }

  @Override
  public <T> T getCache(String cacheName, String key, Class<T> objectClass) {
    String keyGen = keyGen(cacheName, key);
    log.info("Redis get cache: cacheName={}, key={}", cacheName, keyGen);
    String valueStr = (String) redisTemplate.opsForValue().get(keyGen);
    if (valueStr == null) {
      log.info("Cache not found: cacheName={}, key={}", cacheName, keyGen);
      return null;
    } else {
      try {
        return ObjectMapperUtils.fromJson(valueStr, objectClass);
      } catch (Exception ex) {
        log.error("Error when get cache: cacheName={}, key={}", cacheName, keyGen, ex);
        return null;
      }
    }
  }

  @Override
  public <T> T getCache(String cacheName, String key, TypeReference<T> typeReference) {
    String keyGen = keyGen(cacheName, key);
    log.info("Redis get cache: cacheName={}, key={}", cacheName, keyGen);
    String valueStr = (String) redisTemplate.opsForValue().get(keyGen);
    if (valueStr == null) {
      log.info("Cache not found: cacheName={}, key={}", cacheName, keyGen);
      return null;
    } else {
      try {
        return ObjectMapperUtils.fromJson(valueStr, typeReference);
      } catch (Exception ex) {
        log.error("Error when get cache: cacheName={}, key={}", cacheName, keyGen, ex);
        return null;
      }
    }
  }

  @Override
  public void deleteCache(String cacheName, String key) {
    String keyGen = keyGen(cacheName, key);
    log.info("Redis delete cache: cacheName={}, key={}", cacheName, keyGen);
    Boolean isDeleted = redisTemplate.delete(keyGen);
    if (!Boolean.TRUE.equals(isDeleted)) {
      log.info("Key {} does not exist or delete fail", keyGen);
    }
  }

  private String keyGen(String cacheName, Object key) {
    return StringUtils.hasText(cacheName) ? appName + ":" + cacheName + ":" + key : key.toString();
  }
}
