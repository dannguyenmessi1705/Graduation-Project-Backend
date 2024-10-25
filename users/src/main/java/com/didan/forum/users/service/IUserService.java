package com.didan.forum.users.service;

import com.didan.forum.users.dto.request.ChangePasswordAdminDto;
import com.didan.forum.users.dto.request.ChangePasswordUserDto;
import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.request.LoginRequestDto;
import com.didan.forum.users.dto.request.UpdateUserAdminRequestDto;
import com.didan.forum.users.dto.request.UpdateUserRequestDto;
import com.didan.forum.users.dto.response.LoginResponseDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import java.util.List;

public interface IUserService {

  List<UserResponseDto> findUsers(String keyword, int page, int size);

  UserResponseDto getDetailUser(String userId);

  UserResponseDto createUser(boolean isVerified, CreateUserRequestDto requestDto);

  UserResponseDto updateUser(String userId, UpdateUserRequestDto requestDto);

  UserResponseDto updateUserByAdmin(String userId, UpdateUserAdminRequestDto requestDto);

  LoginResponseDto loginUser(LoginRequestDto requestDto);

  void logoutUser(String refreshToken);

  void updatePassword(String userId, ChangePasswordUserDto requestDto);

  void updatePasswordAdmin(String userId, ChangePasswordAdminDto requestDto);

  void deleteUser(String userId);

  void requestResetPassword(String userId);

  boolean checkUserExist(String userId);
}
