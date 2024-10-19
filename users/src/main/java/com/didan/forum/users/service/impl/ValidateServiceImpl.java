package com.didan.forum.users.service.impl;

import com.didan.forum.users.exception.ResourceNotFoundException;
import com.didan.forum.users.service.IRedisService;
import com.didan.forum.users.service.IVerifyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class ValidateServiceImpl implements IVerifyService {
  private final IRedisService redisService;

  @Override
  public void activateUser(String token) {
    String tokenExistInRedis = redisService.getCache("validate", token, String.class);
    if (tokenExistInRedis == null) {
      log.error("Token not found in Redis");
      throw new ResourceNotFoundException("Token is expired or invalid");
    }
    redisService.deleteCache("validate", token);
  }
}
