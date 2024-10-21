package com.didan.forum.users.service;

import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.request.LoginRequestDto;
import com.didan.forum.users.dto.response.LoginResponseDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import java.util.List;

public interface IUserService {

  List<UserResponseDto> findUsers();

  UserResponseDto getDetailUser(String userId);

  boolean reportUser(String userId);

  UserResponseDto createUser(boolean isVerified, CreateUserRequestDto requestDto);

  LoginResponseDto loginUser(LoginRequestDto requestDto);

  void logoutUser(String refreshToken);
}
