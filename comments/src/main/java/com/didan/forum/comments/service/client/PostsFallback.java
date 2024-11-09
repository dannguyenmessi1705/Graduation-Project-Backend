package com.didan.forum.comments.service.client;

import com.didan.forum.comments.constant.RedisCacheConstant;
import com.didan.forum.comments.dto.Status;
import com.didan.forum.comments.dto.client.PostResponseDto;
import com.didan.forum.comments.dto.response.GeneralResponse;
import com.didan.forum.comments.service.IRedisService;
import com.didan.forum.comments.service.VerifyPostService;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class PostsFallback implements PostsFeignClient {

  private final IRedisService redisService;
  private final VerifyPostService verifyPostService;

  @Override
  public ResponseEntity<GeneralResponse<Boolean>> checkPostExist(String postId) {
    Status status = new Status(null, HttpStatus.SERVICE_UNAVAILABLE.value(), "Service unavailable", LocalDateTime.now());
    try {
      boolean isPostExist = verifyPostService.verifyPost(postId);
      return new ResponseEntity<>(new GeneralResponse<>(status, isPostExist), HttpStatus.SERVICE_UNAVAILABLE);
    } catch (Exception e) {
      return new ResponseEntity<>(new GeneralResponse<>(status, false), HttpStatus.SERVICE_UNAVAILABLE);
    }
  }

  @Override
  public ResponseEntity<GeneralResponse<PostResponseDto>> getPost(String postId) {
    Status status = new Status(null, HttpStatus.SERVICE_UNAVAILABLE.value(), "Service unavailable", LocalDateTime.now());
    PostResponseDto post = redisService.getCache(RedisCacheConstant.POST_DETAIL_CACHE.getCacheName(), postId, PostResponseDto.class);
    if (post == null) {
      return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.SERVICE_UNAVAILABLE);
    }
    return new ResponseEntity<>(new GeneralResponse<>(status, post), HttpStatus.SERVICE_UNAVAILABLE);
  }
}
