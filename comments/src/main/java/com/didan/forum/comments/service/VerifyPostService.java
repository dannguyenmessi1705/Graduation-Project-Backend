package com.didan.forum.comments.service;

import com.didan.forum.comments.dto.response.GeneralResponse;
import com.didan.forum.comments.service.client.PostsFeignClient;
import com.didan.forum.comments.service.client.UsersFeignClient;
import com.github.benmanes.caffeine.cache.CacheLoader;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.github.benmanes.caffeine.cache.LoadingCache;
import jakarta.annotation.PostConstruct;
import java.time.Duration;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class VerifyPostService {
  private final PostsFeignClient postsFeignClient;
  private LoadingCache<String, Boolean> loadingCache;
  private static final int EXPIRETIME = 30;

  @PostConstruct
  public void init() {
    CacheLoader<String, Boolean> loader = this::load;
    loadingCache = Caffeine.newBuilder()
        .maximumSize(Integer.MAX_VALUE)
        .expireAfterWrite(Duration.ofMinutes(EXPIRETIME))
        .evictionListener((key, value, cause) -> log.info("removing key - {}, cause - {}", key, cause))
        .build(loader);
  }

  private Boolean load(String key) {
    try {
      log.info("CacheLocal load key - {}", key);
      ResponseEntity<GeneralResponse<Boolean>> response = postsFeignClient.checkPostExist(key);
      if (response.getBody() != null) {
        return response.getBody().getData();
      }
      return false;
    } catch (Exception ex) {
      log.error("CacheLocal load error " + ex.getMessage(), ex);
      return false;
    }
  }

  public boolean verifyPost(String postId) {
    return loadingCache.get(postId);
  }

  public void invalidateCache(String postId) {
    loadingCache.invalidate(postId);
  }
}
