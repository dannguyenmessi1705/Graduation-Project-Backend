package com.didan.forum.users.service;

import com.didan.forum.users.dto.request.ChangePasswordAdminDto;

public interface IVerifyService {
  void activateUser(String token);
  ChangePasswordAdminDto resetPassword(String token);
}
