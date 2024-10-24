package com.didan.forum.users.controller.impl;

import com.didan.forum.users.controller.IUserController;
import com.didan.forum.users.dto.Status;
import com.didan.forum.users.dto.request.ChangePasswordUserDto;
import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.request.LoginRequestDto;
import com.didan.forum.users.dto.request.LogoutRequestDto;
import com.didan.forum.users.dto.request.UpdateUserRequestDto;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.dto.response.LoginResponseDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import com.didan.forum.users.exception.ErrorActionException;
import com.didan.forum.users.service.IUserService;
import com.didan.forum.users.utils.ImageGenerator;
import java.time.LocalDateTime;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
public class UserControllerImpl implements IUserController {

  private final IUserService userService;

  @Value("${app.pagination.defaultSize}")
  private int defaultSize;

  @Value("${app.baseUrl}")
  private String baseUrl;

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
    Status status = new Status("/users/logout", HttpStatus.OK.value(),
        "User logged out successfully",
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

  @Override
  public ResponseEntity<GeneralResponse<UserResponseDto>> updateUser(String userIdHeader,
      String userId,
      UpdateUserRequestDto requestDto) {
    log.info("===== Start updating user =====");
    if (!userIdHeader.equals(userId)) {
      Status status = new Status("/users/update/" + userId, HttpStatus.FORBIDDEN.value(),
          "You are not authorized to update this user",
          LocalDateTime.now());
      return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.FORBIDDEN);
    }
    UserResponseDto responseDto = userService.updateUser(userId, requestDto);
    Status status = new Status("/users/update/" + userId, HttpStatus.OK.value(), "User updated "
        + "successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<UserResponseDto>> getDetailUser(String userId) {
    log.info("===== Start getting user details =====");
    UserResponseDto responseDto = userService.getDetailUser(userId);
    Status status = new Status("/users/detail/" + userId, HttpStatus.OK.value(), "User details "
        + "retrieved successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<List<UserResponseDto>>> findUsers(String keyword,
      int page) {
    log.info("===== Start finding users =====");
    if (!StringUtils.hasText(String.valueOf(page)) || page < 0) {
      page = 0;
    }
    List<UserResponseDto> responseDto = userService.findUsers(keyword, page, defaultSize);
    Status status = new Status("/users/find", HttpStatus.OK.value(), "Users found successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> updatePasswordByUser(String userIdHeader,
      String userId, ChangePasswordUserDto requestDto) {
    log.info("===== Start updating password by user =====");
    if (!userIdHeader.equals(userId)) {
      Status status = new Status("/users/update/password/" + userId, HttpStatus.FORBIDDEN.value(),
          "You are not authorized to update password this user",
          LocalDateTime.now());
      return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.FORBIDDEN);
    }
    userService.updatePassword(userId, requestDto);
    Status status = new Status("/users/update/password/" + userId, HttpStatus.OK.value(),
        "Password updated successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> requestResetPassword(String userId) {
    log.info("===== Start requesting reset password =====");
    userService.requestResetPassword(userId);
    Status status = new Status("/users/reset/password/" + userId, HttpStatus.OK.value(),
        "Reset password requested successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<byte[]> getQRCode(String userId) {
    byte[] bytes = new byte[0];
    String pathUserDetails = baseUrl + "/users/detail/" + userId;
    try {
      bytes = ImageGenerator.generateQRCodeImage(pathUserDetails, 350, 350);
    } catch (Exception e) {
      throw new ErrorActionException("Could not generate QR code");
    }
    return ResponseEntity.ok().header("Content-Disposition", "attachment; filename=" + "qrcode")
        .contentType(MediaType.IMAGE_PNG).body(bytes);
  }
}
