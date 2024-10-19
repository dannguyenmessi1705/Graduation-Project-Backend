package com.didan.forum.users.service.impl;

import com.didan.forum.users.dto.SendMailWithTemplate;
import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import com.didan.forum.users.entity.UserEntity;
import com.didan.forum.users.exception.ResourceAlreadyExistException;
import com.didan.forum.users.repository.UserRepository;
import com.didan.forum.users.service.IKeycloakUserService;
import com.didan.forum.users.service.IUserService;
import com.didan.forum.users.service.minio.MinioService;
import com.didan.forum.users.service.sendgrid.SendgridService;
import com.didan.forum.users.utils.MapperUtils;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service
public class UserServiceImpl implements IUserService {

  private final UserRepository userRepository;
  private final PasswordEncoder passwordEncoder;
  private final SendgridService sendgridService;
  private final RedisServiceImpl redisService;
  private final StreamBridge streamBridge;
  private final MinioService minio;
  private final IKeycloakUserService keycloakUserService;

  @Value("${minio.bucket-name}")
  private String bucketName;

  @Value("${minio.endpoint}")
  private String minioEndpoint;

  @Value("${sendgrid.urlAuth}")
  private String urlAuth;

  @Override
  public List<UserResponseDto> getAllUsers() {
    return List.of();
  }

  @Override
  public UserResponseDto getDetailUser(String userId) {
    return null;
  }

  @Override
  public boolean reportUser(String userId) {
    return false;
  }

  @Override
  public UserResponseDto createUser(boolean isVerified, CreateUserRequestDto requestDto) {
    userRepository.findFirstByEmailIgnoreCase(requestDto.getEmail()).ifPresent(user -> {
      throw new ResourceAlreadyExistException("Email already exists");
    });
    userRepository.findFirstByUsernameIgnoreCase(requestDto.getUsername()).ifPresent(user -> {
      throw new ResourceAlreadyExistException("Username already exists");
    });
    userRepository.findFirstByPhoneNumber(requestDto.getPhoneNumber()).ifPresent(user -> {
      throw new ResourceAlreadyExistException("Phone number already exists");
    });

    UserResponseDto userResponseDto = keycloakUserService.createUserInKeycloak(requestDto, null,
        null, isVerified);

    log.info("Mapping CreateUserRequestDto to UserEntity");
    UserEntity user = MapperUtils.map(requestDto, UserEntity.class);
    user.setPicture(userResponseDto.getPicture());
    user.setVerified(userResponseDto.isVerified());
    user.setId(userResponseDto.getId());
    user.setPassword(passwordEncoder.encode(requestDto.getPassword()));
    userRepository.save(user);
    SendMailWithTemplate objectMail = MapperUtils.map(user, SendMailWithTemplate.class);
    String token = RandomStringUtils.random(100, true, true);
    String messageAuthUrl = urlAuth + token;
    objectMail.setMessage(messageAuthUrl);
    log.info("Sending Communication request to Kafka for the details : {}", objectMail);
    boolean isSendKafka = streamBridge.send("sendUserRegister-out-0", objectMail);
    log.info("Is the Communication request successfully triggered ? : {}", isSendKafka);
    return MapperUtils.map(user, UserResponseDto.class);
  }
}
