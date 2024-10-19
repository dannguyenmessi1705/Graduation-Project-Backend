package com.didan.forum.users.service;

import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import java.util.List;

public interface IUserService {
  List<UserResponseDto> getAllUsers();

  UserResponseDto getDetailUser(String userId);

  boolean reportUser(String userId);

  UserResponseDto createUser(CreateUserRequestDto requestDto);


}
