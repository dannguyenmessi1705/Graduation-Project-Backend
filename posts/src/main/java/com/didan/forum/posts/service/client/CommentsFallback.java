package com.didan.forum.posts.service.client;

import com.didan.forum.posts.constant.RedisCacheConstant;
import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.Status;
import com.didan.forum.posts.service.IRedisService;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class CommentsFallback implements CommentsFeignClient {

  private final IRedisService redisService;

  @Override
  public ResponseEntity<GeneralResponse<Long>> countComments(String postId) {
    Status status = new Status(null, HttpStatus.SERVICE_UNAVAILABLE.value(), "Service unavailable", LocalDateTime.now());
    Long totalComments = redisService.getCache(RedisCacheConstant.COMMENT_QUANTITY_CACHE.getCacheName(), postId, Long.class);
    if (totalComments == null) {
      return new ResponseEntity<>(new GeneralResponse<>(status, 0L), HttpStatus.SERVICE_UNAVAILABLE);
    } else {
      return new ResponseEntity<>(new GeneralResponse<>(status, totalComments), HttpStatus.SERVICE_UNAVAILABLE);
    }
  }
}
