package com.didan.forum.users.service.impl;

import com.didan.forum.users.dto.SendMailWithTemplate;
import com.didan.forum.users.dto.request.ChangePasswordAdminDto;
import com.didan.forum.users.dto.request.ChangePasswordUserDto;
import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.request.LoginRequestDto;
import com.didan.forum.users.dto.request.UpdateUserAdminRequestDto;
import com.didan.forum.users.dto.request.UpdateUserRequestDto;
import com.didan.forum.users.dto.response.LoginResponseDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import com.didan.forum.users.entity.UserEntity;
import com.didan.forum.users.exception.ErrorActionException;
import com.didan.forum.users.exception.ResourceAlreadyExistException;
import com.didan.forum.users.exception.ResourceNotFoundException;
import com.didan.forum.users.repository.TokenRequestRepository;
import com.didan.forum.users.repository.UserRepository;
import com.didan.forum.users.service.IKeycloakRoleService;
import com.didan.forum.users.service.IKeycloakUserService;
import com.didan.forum.users.service.IRestTemplateService;
import com.didan.forum.users.service.IUserService;
import com.didan.forum.users.service.minio.MinioService;
import com.didan.forum.users.utils.ImageGenerator;
import com.didan.forum.users.utils.MapperUtils;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;

@Slf4j
@RequiredArgsConstructor
@Service
public class UserServiceImpl implements IUserService {

  private final UserRepository userRepository;
  private final PasswordEncoder passwordEncoder;
  private final StreamBridge streamBridge;
  private final IKeycloakUserService keycloakUserService;
  private final IRestTemplateService restTemplateService;
  private final IKeycloakRoleService keycloakRoleService;
  private final TokenRequestRepository tokenRequestRepository;
  private final MinioService minioService;

  @Value("${minio.bucket-name}")
  private String bucketName;

  @Value("${minio.endpoint}")
  private String minioEndpoint;

  @Value("${sendgrid.urlVerify}")
  private String urlAuth;

  @Value("${keycloak.client.client-id}")
  private String clientId;

  @Value("${keycloak.client.client-secret}")
  private String clientSecret;

  @Value("${keycloak.client.token-url}")
  private String tokenUrl;

  @Value("${keycloak.client.grant-type-login}")
  private String grantTypeLogin;

  @Value("${keycloak.client.grant-type-logout}")
  private String grantTypeLogout;

  @Override
  public List<UserResponseDto> findUsers(
      String keyword, int page, int size
  ) {
    Pageable pageable = PageRequest.of(page, size, Sort.by("username"));

    List<UserResponseDto> users = userRepository.findAllByUsernameContainingIgnoreCase(keyword,
            pageable).stream()
        .map(user -> MapperUtils.map(user, UserResponseDto.class)).toList();

    if (users.isEmpty()) {
      throw new ResourceNotFoundException("No user found");
    }
    return users;
  }

  @Override
  public UserResponseDto getDetailUser(String userId) {
    UserEntity user = userRepository.findById(userId)
        .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    return MapperUtils.map(user, UserResponseDto.class);
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
    String picturePath;
    if (requestDto.getPicture() != null) {
      log.info("Uploading avatar to Minio");
      minioService.createBucket(bucketName);
      String fileName = requestDto.getPicture().getOriginalFilename();
      if (!StringUtils.hasText(fileName)) {
        throw new ErrorActionException("File name is empty");
      }
      picturePath = "avatar_" + requestDto.getUsername() + "." + fileName.split("\\.")[1];
      String contentType = requestDto.getPicture().getContentType();
      minioService.uploadFile(bucketName, requestDto.getPicture(), picturePath, contentType);
      log.info("Avatar uploaded successfully");
    } else {
      byte[] pictureDefault = ImageGenerator.generateAvatar(requestDto.getUsername(), 480);
      InputStream inputStream = new ByteArrayInputStream(pictureDefault);
      picturePath = "avatar_" + requestDto.getUsername() + ".png";
      minioService.createBucket(bucketName);
      minioService.uploadFile(bucketName, picturePath, inputStream, MediaType.IMAGE_PNG_VALUE);
    }

    String pictureUrl = getUrlMinio(picturePath);
    UserResponseDto userResponseDto = keycloakUserService.createUserInKeycloak(requestDto, pictureUrl,
        isVerified);

    log.info("Mapping CreateUserRequestDto to UserEntity");
    UserEntity user = MapperUtils.map(requestDto, UserEntity.class);
    user.setPicture(userResponseDto.getPicture());
    user.setVerified(userResponseDto.isVerified());
    user.setId(userResponseDto.getId());
    user.setPassword(passwordEncoder.encode(requestDto.getPassword()));
    userRepository.save(user);

    if (!isVerified) {
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
      keycloakRoleService.addRoleToUserInKeycloak(user.getId(), "inactive");
    } else {
      keycloakRoleService.addRoleToUserInKeycloak(user.getId(), "user");
    }
    return MapperUtils.map(user, UserResponseDto.class);
  }

  @Override
  @Transactional
  @Modifying
  public UserResponseDto updateUser(String userId, UpdateUserRequestDto requestDto) {
    userRepository.findById(userId)
        .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    if (StringUtils.hasText(requestDto.getEmail())) {
      userRepository.findFirstByEmailIgnoreCase(requestDto.getEmail()).ifPresent(user -> {
        throw new ResourceAlreadyExistException("Email already exists");
      });
    }
    if (StringUtils.hasText(requestDto.getPhoneNumber())) {
      userRepository.findFirstByPhoneNumber(requestDto.getPhoneNumber()).ifPresent(user -> {
        throw new ResourceAlreadyExistException("Phone number already exists");
      });
    }
    UserResponseDto updateUserRequest = keycloakUserService.updateUserInKeycloak(userId,
        MapperUtils.map(requestDto, UpdateUserAdminRequestDto.class));

    UserEntity userEntity = MapperUtils.map(updateUserRequest, UserEntity.class);
    userRepository.save(userEntity);
    return updateUserRequest;
  }

  @Override
  @Transactional
  @Modifying
  public UserResponseDto updateUserByAdmin(String userId, UpdateUserAdminRequestDto requestDto) {
    userRepository.findById(userId)
        .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    if (StringUtils.hasText(requestDto.getEmail())) {
      userRepository.findFirstByEmailIgnoreCase(requestDto.getEmail()).ifPresent(user -> {
        throw new ResourceAlreadyExistException("Email already exists");
      });
    }
    if (StringUtils.hasText(requestDto.getPhoneNumber())) {
      userRepository.findFirstByPhoneNumber(requestDto.getPhoneNumber()).ifPresent(user -> {
        throw new ResourceAlreadyExistException("Phone number already exists");
      });
    }
    UserResponseDto updateUserRequest = keycloakUserService.updateUserInKeycloak(userId,
        requestDto);

    UserEntity userEntity = MapperUtils.map(updateUserRequest, UserEntity.class);
    userRepository.save(userEntity);
    return updateUserRequest;
  }

  @Override
  public LoginResponseDto loginUser(LoginRequestDto requestDto) {
    UserEntity user = userRepository.findFirstByUsernameIgnoreCase(requestDto.getUsername())
        .orElseThrow(() -> new ResourceAlreadyExistException("username or password doesn't match"));
    if (!passwordEncoder.matches(requestDto.getPassword(), user.getPassword())) {
      throw new ResourceAlreadyExistException("username or password doesn't match");
    }

    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

    MultiValueMap<String, String> objectRequest = new LinkedMultiValueMap<>();
    objectRequest.add("username", requestDto.getUsername());
    objectRequest.add("password", requestDto.getPassword());
    objectRequest.add("grant_type", grantTypeLogin);
    objectRequest.add("client_id", clientId);
    objectRequest.add("client_secret", clientSecret);

    ResponseEntity<LoginResponseDto> loginResponse = restTemplateService.process(HttpMethod.POST,
        tokenUrl + "token", headers, objectRequest, LoginResponseDto.class);

    if (!loginResponse.getStatusCode().is2xxSuccessful()) {
      throw new ErrorActionException("login failed");
    }
    return loginResponse.getBody();
  }

  @Override
  public void logoutUser(String refreshToken) {
    if (!StringUtils.hasText(refreshToken)) {
      throw new ErrorActionException("refresh token is required");
    }

    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

    MultiValueMap<String, String> objectRequest = new LinkedMultiValueMap<>();
    objectRequest.add("client_id", clientId);
    objectRequest.add("client_secret", clientSecret);
    objectRequest.add("grant_type", grantTypeLogout);
    objectRequest.add("refresh_token", refreshToken);

    ResponseEntity<Void> logoutResponse = restTemplateService.process(HttpMethod.POST,
        tokenUrl + "logout", headers, objectRequest, Void.class);
    if (!logoutResponse.getStatusCode().is2xxSuccessful()) {
      throw new ErrorActionException("logout failed");
    }
  }

  @Override
  @Transactional
  @Modifying
  public void updatePassword(String userId, ChangePasswordUserDto requestDto) {
    UserEntity user = userRepository.findById(userId).orElseThrow(
        () -> new ResourceNotFoundException("User not found"));

    if (!passwordEncoder.matches(requestDto.getOldPassword(), user.getPassword())) {
      throw new ErrorActionException("Password is incorrect");
    }

    keycloakUserService.updateUserPasswordInKeycloak(userId, requestDto.getNewPassword());

    user.setPassword(passwordEncoder.encode(requestDto.getNewPassword()));
    userRepository.save(user);
  }

  @Override
  @Transactional
  @Modifying
  public void updatePasswordAdmin(String userId, ChangePasswordAdminDto requestDto) {
    UserEntity user = userRepository.findById(userId).orElseThrow(
        () -> new ResourceNotFoundException("User not found"));

    keycloakUserService.updateUserPasswordInKeycloak(userId, requestDto.getPassword());

    user.setPassword(passwordEncoder.encode(requestDto.getPassword()));

    userRepository.save(user);
  }

  @Override
  @Transactional
  @Modifying
  public void deleteUser(String userId) {
    UserEntity user = userRepository.findById(userId)
        .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    keycloakUserService.deleteUserFromKeycloak(userId);
    userRepository.delete(user);
  }

  @Override
  public void requestResetPassword(String userId) {
    UserEntity user = userRepository.findById(userId)
        .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    String token = RandomStringUtils.random(100, true, true);

    String messageAuthUrl = urlAuth + "reset?token=" + token;
    SendMailWithTemplate objectMail = MapperUtils.map(user, SendMailWithTemplate.class);
    objectMail.setUserId(user.getId());
    objectMail.setMessage(messageAuthUrl);
    objectMail.setGuide("Click this link to reset password, the link is expired in 10 minutes");
    objectMail.setTitle("Reset your password");
    log.info("Sending Communication request to Kafka for the details : {}", objectMail);
    boolean isSendKafka = streamBridge.send("sendUserEmail-out-0", objectMail);
    log.info("Is the Communication request successfully triggered ? : {}", isSendKafka);
  }

  @Override
  public boolean checkUserExist(String userId) {
    return userRepository.existsById(userId);
  }

  private String getUrlMinio(String path) {
    String url = minioService.getPresignedObjectUrl(bucketName, path);
    return minioService.getUTF8ByURLDecoder(url);
  }


}
