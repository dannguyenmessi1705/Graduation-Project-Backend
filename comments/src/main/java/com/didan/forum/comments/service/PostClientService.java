package com.didan.forum.comments.service;

import com.didan.forum.comments.constant.RedisCacheConstant;
import com.didan.forum.comments.dto.client.PostResponseDto;
import com.didan.forum.comments.dto.response.GeneralResponse;
import com.didan.forum.comments.service.client.PostsFeignClient;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class PostClientService {

  private final PostsFeignClient postsFeignClient;
  private final IRedisService redisService;

  public PostClientService(
      @Qualifier("com.didan.forum.comments.service.client.PostsFeignClient") PostsFeignClient postsFeignClient,
      IRedisService redisService) {
    this.postsFeignClient = postsFeignClient;
    this.redisService = redisService;
  }

  public PostResponseDto getPostDetail(String postId) {
    PostResponseDto post = redisService.getCache(RedisCacheConstant.POST_DETAIL_CACHE.getCacheName(), postId, PostResponseDto.class);
    if (post == null) {
      post = getPostFromClient(postId);
      if (post != null) {
        redisService.setCache(RedisCacheConstant.POST_DETAIL_CACHE.getCacheName(), postId, post);
      }
    }
    return post;
  }

  private PostResponseDto getPostFromClient(String postId) {
    ResponseEntity<GeneralResponse<PostResponseDto>> response = postsFeignClient.getPost(postId);
    if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
      return response.getBody().getData();
    }
    return null;
  }
}
