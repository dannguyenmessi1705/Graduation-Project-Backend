package com.didan.forum.users.service.impl;

import com.didan.forum.users.dto.SendMailWithTemplate;
import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import com.didan.forum.users.entity.UserEntity;
import com.didan.forum.users.exception.ErrorActionException;
import com.didan.forum.users.exception.ResourceAlreadyExistException;
import com.didan.forum.users.repository.UserRepository;
import com.didan.forum.users.service.IUserService;
import com.didan.forum.users.service.sendgrid.SendgridService;
import com.didan.forum.users.utils.MapperUtils;
import com.didan.forum.users.service.minio.MinioService;
import java.util.List;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

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
  public UserResponseDto createUser(CreateUserRequestDto requestDto) {
    userRepository.findFirstByEmailIgnoreCase(requestDto.getEmail()).ifPresent(user -> {
      throw new ResourceAlreadyExistException("Email already exists");
    });
    userRepository.findFirstByUsernameIgnoreCase(requestDto.getUsername()).ifPresent(user -> {
      throw new ResourceAlreadyExistException("Username already exists");
    });
    userRepository.findFirstByPhoneNumber(requestDto.getPhoneNumber()).ifPresent(user -> {
      throw new ResourceAlreadyExistException("Phone number already exists");
    });
    log.info("Mapping CreateUserRequestDto to UserEntity");
    UserEntity user = MapperUtils.map(requestDto, UserEntity.class);
    String userId = UUID.randomUUID().toString();

    if (!requestDto.getPicture().isEmpty() || requestDto.getPicture() != null) {
      log.info("Uploading avatar to Minio");
      minio.createBucket(bucketName);
      String fileName = requestDto.getPicture().getOriginalFilename();
      if (!StringUtils.hasText(fileName)) {
        throw new ErrorActionException("File name is empty");
      }
      String pictureUrl = "avatar_" + userId + "_" + fileName.split("\\.")[1];
      String contentType = requestDto.getPicture().getContentType();
      minio.uploadFile(bucketName, requestDto.getPicture(), pictureUrl, contentType);
      log.info("Avatar uploaded successfully");
      user.setPicture(minioEndpoint + "/" + bucketName + "/" + pictureUrl);
    }
    user.setPassword(passwordEncoder.encode(requestDto.getPassword()));
    userRepository.save(user);
    SendMailWithTemplate objectMail = MapperUtils.map(user, SendMailWithTemplate.class);
    String token = RandomStringUtils.random(100, true, true);
    String messageAuthUrl = urlAuth + token;
    objectMail.setMessage(messageAuthUrl);
    log.info("Sending Communication request to Kafka for the details : {}", objectMail);
    boolean isSendKafka = streamBridge.send("sendEmailRegister-out-0", objectMail);
    log.info("Is the Communication request successfully triggered ? : {}", isSendKafka);
    return MapperUtils.map(user, UserResponseDto.class);
  }
}
