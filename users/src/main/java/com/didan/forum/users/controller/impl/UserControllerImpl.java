package com.didan.forum.users.controller.impl;

import com.didan.forum.users.controller.IUserController;
import com.didan.forum.users.dto.Status;
import com.didan.forum.users.dto.request.ChangePasswordUserDto;
import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.request.LoginRequestDto;
import com.didan.forum.users.dto.request.LogoutRequestDto;
import com.didan.forum.users.dto.request.ReportUserDto;
import com.didan.forum.users.dto.request.UpdateUserRequestDto;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.dto.response.LoginResponseDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import com.didan.forum.users.exception.ErrorActionException;
import com.didan.forum.users.filter.RequestContext;
import com.didan.forum.users.service.IReportUserService;
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
  private final IReportUserService reportUserService;

  @Value("${app.pagination.defaultSize}")
  private int defaultSize;

  @Value("${app.baseUrl}")
  private String baseUrl;

  @Override
  public ResponseEntity<GeneralResponse<LoginResponseDto>> loginUser(LoginRequestDto requestDto) {
    log.info("===== Start logging in user =====");
    LoginResponseDto responseDto = userService.loginUser(requestDto);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "User logged in successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> logoutUser(LogoutRequestDto requestDto) {
    log.info("===== Start logging out user =====");
    userService.logoutUser(requestDto.getRefreshToken());
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(),
        "User logged out successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<UserResponseDto>> createUser(
      CreateUserRequestDto requestDto) {
    log.info("===== Start creating user =====");
    UserResponseDto responseDto = userService.createUser(false, requestDto);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.CREATED.value(),
        "User created successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.CREATED);
  }

  @Override
  public ResponseEntity<GeneralResponse<UserResponseDto>> updateUser(UpdateUserRequestDto requestDto) {
    log.info("===== Start updating user =====");
    UserResponseDto responseDto = userService.updateUser(RequestContext.getRequest().getHeader("X-User-Id"),
        requestDto);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "User updated "
        + "successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<UserResponseDto>> getDetailUser(String userId) {
    log.info("===== Start getting user details =====");
    UserResponseDto responseDto = userService.getDetailUser(userId);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "User details "
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
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "Users found successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> updatePasswordByUser(ChangePasswordUserDto requestDto) {
    log.info("===== Start updating password by user =====");
    userService.updatePassword(RequestContext.getRequest().getHeader("X-User-Id"), requestDto);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(),
        "Password updated successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> requestResetPassword(String username) {
    log.info("===== Start requesting reset password =====");
    userService.requestResetPassword(username);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(),
        "Reset password requested successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<byte[]> getQRCode() {
    byte[] bytes = new byte[0];
    String pathUserDetails = baseUrl + "/users/detail/" + RequestContext.getRequest().getHeader("X-User-Id");
    try {
      bytes = ImageGenerator.generateQRCodeImage(pathUserDetails, 350, 350);
    } catch (Exception e) {
      throw new ErrorActionException("Could not generate QR code");
    }
    return ResponseEntity.ok().header("Content-Disposition", "attachment; filename=" + "qrcode")
        .contentType(MediaType.IMAGE_PNG).body(bytes);
  }

  @Override
  public ResponseEntity<GeneralResponse<Boolean>> checkUserExists(String userId) {
    log.info("===== Start checking user exists =====");
    boolean isExistUser = userService.checkUserExist(userId);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(),
        isExistUser ? "User exists" : "User does not exist",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, isExistUser), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> reportUser(String userId,
      ReportUserDto reportUserDto) {
    log.info("===== Start reporting user =====");
    reportUserService.reportUser(RequestContext.getRequest().getHeader("X-User-Id"), userId, reportUserDto);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(),
        "User reported successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }
}
