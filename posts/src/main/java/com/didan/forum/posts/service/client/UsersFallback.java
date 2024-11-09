package com.didan.forum.posts.service.client;

import com.didan.forum.posts.constant.RedisCacheConstant;
import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.Status;
import com.didan.forum.posts.dto.client.UserResponseDto;
import com.didan.forum.posts.service.IRedisService;
import com.didan.forum.posts.service.VerifyUserService;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UsersFallback implements UsersFeignClient {

  private final IRedisService redisService;
  private final VerifyUserService verifyUserService;

  @Override
  public ResponseEntity<GeneralResponse<UserResponseDto>> getDetailUser(String userId) {
    Status status = new Status(null, HttpStatus.SERVICE_UNAVAILABLE.value(), "Service unavailable", LocalDateTime.now());
    UserResponseDto userResponseDto = redisService.getCache(RedisCacheConstant.USER_CACHE.getCacheName(), userId, UserResponseDto.class);
    if (userResponseDto == null) {
      return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.SERVICE_UNAVAILABLE);
    } else {
      return new ResponseEntity<>(new GeneralResponse<>(status, userResponseDto), HttpStatus.SERVICE_UNAVAILABLE);
    }
  }

  @Override
  public ResponseEntity<GeneralResponse<Boolean>> checkUserExists(String userId) {
    Status status = new Status(null, HttpStatus.SERVICE_UNAVAILABLE.value(), "Service unavailable", LocalDateTime.now());
    try {
      boolean userExists = verifyUserService.verifyUser(userId);
      return new ResponseEntity<>(new GeneralResponse<>(status, userExists), HttpStatus.SERVICE_UNAVAILABLE);
    } catch (Exception ex) {
      return new ResponseEntity<>(new GeneralResponse<>(status, false), HttpStatus.SERVICE_UNAVAILABLE);
    }
  }
}
