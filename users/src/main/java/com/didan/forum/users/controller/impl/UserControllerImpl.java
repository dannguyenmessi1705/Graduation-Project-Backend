package com.didan.forum.users.controller.impl;

import com.didan.forum.users.controller.IUserController;
import com.didan.forum.users.dto.Status;
import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.request.LoginRequestDto;
import com.didan.forum.users.dto.request.LogoutRequestDto;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.dto.response.LoginResponseDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import com.didan.forum.users.service.IKeycloakUserService;
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
  private final IKeycloakUserService keycloakUserService;

  @Override
  public ResponseEntity<GeneralResponse<LoginResponseDto>> loginUser(LoginRequestDto requestDto) {
    log.info("===== Start logging in user =====");
    LoginResponseDto responseDto = userService.loginUser(requestDto);
    Status status = new Status("/users/login", HttpStatus.OK.value(), "User logged in successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> logoutUser(LogoutRequestDto requestDto) {
    log.info("===== Start logging out user =====");
    userService.logoutUser(requestDto.getRefreshToken());
    Status status = new Status("/users/logout", HttpStatus.OK.value(), "User logged out successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<UserResponseDto>> createUser(
      CreateUserRequestDto requestDto) {
    log.info("===== Start creating user =====");
    UserResponseDto responseDto = userService.createUser(false, requestDto);
    Status status = new Status("/users/register", HttpStatus.CREATED.value(),
        "User created successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.CREATED);
  }
}
