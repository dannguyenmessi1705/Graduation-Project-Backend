package com.didan.forum.users.controller.impl;

import com.didan.forum.users.controller.IUserController;
import com.didan.forum.users.dto.Status;
import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.dto.response.UserResponseDto;
import com.didan.forum.users.service.IUserService;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
public class UserControllerImpl implements IUserController {
  private final IUserService userService;

  @Override
  public ResponseEntity<GeneralResponse<UserResponseDto>> createUser(
      CreateUserRequestDto requestDto) {
    log.info("===== Start creating user =====");
    UserResponseDto responseDto = userService.createUser(requestDto);
    Status status = new Status("/users/register", HttpStatus.CREATED.value(), "User created successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.CREATED);
  }
}
