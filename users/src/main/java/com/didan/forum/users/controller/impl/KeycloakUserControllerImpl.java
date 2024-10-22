package com.didan.forum.users.controller.impl;

import com.didan.forum.users.controller.IKeycloakUserController;
import com.didan.forum.users.dto.Status;
import com.didan.forum.users.dto.request.ChangePasswordAdminDto;
import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.request.UpdateUserAdminRequestDto;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.dto.response.UserResponseDto;
import com.didan.forum.users.service.IKeycloakUserService;
import com.didan.forum.users.service.IUserService;
import java.time.LocalDateTime;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
public class KeycloakUserControllerImpl implements IKeycloakUserController {

  private final IKeycloakUserService keycloakUserService;
  private final IUserService userService;

  @Override
  public ResponseEntity<GeneralResponse<List<UserResponseDto>>> getAllUsersFromKeycloak() {
    List<UserResponseDto> users = keycloakUserService.getAllUsersFromKeycloak();
    Status status = new Status("/users/keycloak/user/all", HttpStatus.OK.value(), "Users "
        + "retrieved successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, users), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<UserResponseDto>> getUserDetailsFromKeycloak(
      String userId) {
    UserResponseDto userKeycloak = keycloakUserService.getUserDetailsFromKeycloak(userId);
    Status status = new Status("/users/keycloak/user/" + userId, HttpStatus.OK.value(), "User "
        + "details retrieved successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, userKeycloak), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<UserResponseDto>> createUserInKeycloak(
      CreateUserRequestDto user) {
    UserResponseDto createdUser = userService.createUser(true, user);
    Status status = new Status("/users/keycloak/user", HttpStatus.CREATED.value(), "User "
        + "created successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, createdUser), HttpStatus.CREATED);
  }

  @Override
  public ResponseEntity<GeneralResponse<UserResponseDto>> updateUserInKeycloak(
      UpdateUserAdminRequestDto requestDto, String userId) {
    UserResponseDto updatedUser = userService.updateUserByAdmin(userId, requestDto);
    Status status = new Status("/users/keycloak/user/" + userId, HttpStatus.OK.value(), "User "
        + "updated successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, updatedUser), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<UserResponseDto>> updateUserPasswordInKeycloak(
      String userId, ChangePasswordAdminDto requestDto) {
    userService.updatePasswordAdmin(userId, requestDto);
    Status status = new Status("/users/keycloak/user/" + userId + "/password",
        HttpStatus.OK.value(),
        "User password updated successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> deleteUserFromKeycloak(String userId) {
    userService.deleteUser(userId);
    Status status = new Status("/users/keycloak/user/" + userId, HttpStatus.NO_CONTENT.value(),
        "User "
            + "deleted successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.NO_CONTENT);
  }
}
