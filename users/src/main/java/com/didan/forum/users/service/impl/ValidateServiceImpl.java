package com.didan.forum.users.service.impl;

import com.didan.forum.users.constant.RoleConstant;
import com.didan.forum.users.dto.SendMailWithTemplate;
import com.didan.forum.users.dto.request.ChangePasswordAdminDto;
import com.didan.forum.users.dto.request.UpdateUserAdminRequestDto;
import com.didan.forum.users.entity.redis.TokenRequestEntity;
import com.didan.forum.users.entity.user.UserEntity;
import com.didan.forum.users.exception.ResourceNotFoundException;
import com.didan.forum.users.repository.TokenRequestRepository;
import com.didan.forum.users.repository.user.UserRepository;
import com.didan.forum.users.service.IKeycloakRoleService;
import com.didan.forum.users.service.IKeycloakUserService;
import com.didan.forum.users.service.IVerifyService;
import com.didan.forum.users.utils.MapperUtils;
import java.util.Locale;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.stream.function.StreamBridge;
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
  private final StreamBridge streamBridge;

  @Value("${sendgrid.urlVerify}")
  private String urlAuth;

  @Override
  public void activateUser(String token) {
    TokenRequestEntity tokenRequestEntity = tokenRequestRepository.findById(token)
        .orElseThrow(() -> new ResourceNotFoundException("Token is expired or invalid"));
    String userId = tokenRequestEntity.getUserId();
    userRepository.updateByIdAndVerified(userId, true);
    keycloakUserService.updateUserInKeycloak(userId,
        UpdateUserAdminRequestDto.builder().isVerified(String.valueOf(Boolean.TRUE)).build());
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

  @Override
  public void resendActivationEmail(String userId) {
    UserEntity user = userRepository.findById(userId)
        .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    if (user.isVerified()) {
      throw new ResourceNotFoundException("User already verified");
    }
    SendMailWithTemplate objectMail = MapperUtils.map(user, SendMailWithTemplate.class);
    String token = RandomStringUtils.random(100, true, true);
    String messageAuthUrl = urlAuth + "activate?token=" + token;
    objectMail.setUserId(user.getId());
    objectMail.setMessage(messageAuthUrl);
    objectMail.setGuide("Click this link to verify account, the link is expired in 10 minutes");
    objectMail.setTitle("Verify your account");
    log.info("Sending Communication request to Kafka for the details : {}", objectMail);
    boolean isSendKafka = streamBridge.send("sendUserEmail-out-0", objectMail);
    log.info("Is the Communication request successfully triggered ? : {}", isSendKafka);
  }
}
