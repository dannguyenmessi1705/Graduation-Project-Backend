package com.didan.forum.users.config.cache;

import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.Cache;
import org.springframework.cache.interceptor.CacheErrorHandler;

@Slf4j
public class RedisCacheErrorHandle implements CacheErrorHandler {

  @Override
  public void handleCacheGetError(RuntimeException exception, Cache cache, Object key) {
    hanldeException(exception);
    log.info("Unable to get into cache {}:{}", cache.getName(), exception.getMessage());
  }

  @Override
  public void handleCachePutError(RuntimeException exception, Cache cache, Object key,
      Object value) {
    hanldeException(exception);
    log.info("Unable to put into cache {}:{}", cache.getName(), exception.getMessage());
  }

  @Override
  public void handleCacheEvictError(RuntimeException exception, Cache cache, Object key) {
    hanldeException(exception);
    log.info("Unable to evict from cache {}:{}", cache.getName(), exception.getMessage());
  }

  @Override
  public void handleCacheClearError(RuntimeException exception, Cache cache) {
    hanldeException(exception);
    log.info("Unable to clear cache {}:{}", cache.getName(), exception.getMessage());
  }

  private void hanldeException(RuntimeException exception) {
    log.error(exception.getMessage(), exception);
  }
}
