package com.didan.forum.comments.service.client;

import com.didan.forum.comments.constant.RedisCacheConstant;
import com.didan.forum.comments.dto.Status;
import com.didan.forum.comments.dto.client.UserResponseDto;
import com.didan.forum.comments.dto.response.GeneralResponse;
import com.didan.forum.comments.service.IRedisService;
import com.didan.forum.comments.service.VerifyUserService;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UsersFallback implements UsersFeignClient {

  private final IRedisService redisService;
  public final VerifyUserService verifyUserService;

  @Override
  public ResponseEntity<GeneralResponse<UserResponseDto>> getDetailUser(String userId) {
    Status status = new Status(null, HttpStatus.SERVICE_UNAVAILABLE.value(), "Service unavailable", LocalDateTime.now());
    UserResponseDto user = redisService.getCache(RedisCacheConstant.USER_CACHE.getCacheName(), userId, UserResponseDto.class);
    if (user == null) {
      return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.SERVICE_UNAVAILABLE);
    }
    return new ResponseEntity<>(new GeneralResponse<>(status, user), HttpStatus.SERVICE_UNAVAILABLE);
  }

  @Override
  public ResponseEntity<GeneralResponse<Boolean>> checkUserExists(String userId) {
    Status status = new Status(null, HttpStatus.SERVICE_UNAVAILABLE.value(), "Service unavailable", LocalDateTime.now());
    try {
      boolean isUserExist = verifyUserService.verifyUser(userId);
      return new ResponseEntity<>(new GeneralResponse<>(status, isUserExist), HttpStatus.SERVICE_UNAVAILABLE);
    } catch (Exception e) {
      return new ResponseEntity<>(new GeneralResponse<>(status, false), HttpStatus.SERVICE_UNAVAILABLE);
    }
  }
}
