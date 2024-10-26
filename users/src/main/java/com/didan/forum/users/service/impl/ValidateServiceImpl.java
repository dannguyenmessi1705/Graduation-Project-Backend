package com.didan.forum.users.service.impl;

import com.didan.forum.users.constant.RoleConstant;
import com.didan.forum.users.dto.request.ChangePasswordAdminDto;
import com.didan.forum.users.dto.request.UpdateUserAdminRequestDto;
import com.didan.forum.users.entity.TokenRequestEntity;
import com.didan.forum.users.entity.UserEntity;
import com.didan.forum.users.exception.ResourceNotFoundException;
import com.didan.forum.users.repository.TokenRequestRepository;
import com.didan.forum.users.repository.UserRepository;
import com.didan.forum.users.service.IKeycloakRoleService;
import com.didan.forum.users.service.IKeycloakUserService;
import com.didan.forum.users.service.IRedisService;
import com.didan.forum.users.service.IVerifyService;
import java.util.Locale;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class ValidateServiceImpl implements IVerifyService {
  private final TokenRequestRepository tokenRequestRepository;
  private final UserRepository userRepository;
  private final PasswordEncoder passwordEncoder;
  private final IKeycloakUserService keycloakUserService;
  private final IKeycloakRoleService keycloakRoleService;

  @Override
  public void activateUser(String token) {
    TokenRequestEntity tokenRequestEntity = tokenRequestRepository.findById(token)
        .orElseThrow(() -> new ResourceNotFoundException("Token is expired or invalid"));
    String userId = tokenRequestEntity.getUserId();
    keycloakUserService.updateUserInKeycloak(userId,
        UpdateUserAdminRequestDto.builder().isVerified(true).build());
    keycloakRoleService.removeRoleFromUserInKeycloak(userId, RoleConstant.ROLE_INACTIVE.getRole());
    keycloakRoleService.addRoleToUserInKeycloak(userId, RoleConstant.ROLE_USER.getRole());
    tokenRequestRepository.delete(tokenRequestEntity);
  }

  @Override
  public ChangePasswordAdminDto resetPassword(String token) {
    TokenRequestEntity tokenRequestEntity = tokenRequestRepository.findById(token)
        .orElseThrow(() -> new ResourceNotFoundException("Token is expired or invalid"));
    tokenRequestRepository.delete(tokenRequestEntity);
    UserEntity userEntity = userRepository.findById(tokenRequestEntity.getUserId())
        .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    String newPassword = RandomStringUtils.randomAlphanumeric(8).toUpperCase(Locale.ENGLISH);
    userEntity.setPassword(passwordEncoder.encode(newPassword));
    keycloakUserService.updateUserPasswordInKeycloak(userEntity.getId(), newPassword);
    userRepository.save(userEntity);
    return ChangePasswordAdminDto
        .builder()
        .password(newPassword)
        .build();
  }
}
