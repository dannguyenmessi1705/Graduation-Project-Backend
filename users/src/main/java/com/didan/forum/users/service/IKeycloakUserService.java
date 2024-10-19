package com.didan.forum.users.service;

import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.request.UpdateUserRequestDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import java.util.List;

public interface IKeycloakUserService {

  List<UserResponseDto> getAllUsersFromKeycloak();

  UserResponseDto getUserDetailsFromKeycloak(String userId);

  UserResponseDto createUserInKeycloak(CreateUserRequestDto requestDto, String userId,
      String picture, boolean isVerified);

  UserResponseDto updateUserInKeycloak(String userId, UpdateUserRequestDto requestDto);

  void updateUserPasswordInKeycloak(String userId, String password);

  void deleteUserFromKeycloak(String userId);

}
