package com.didan.forum.users.service.impl;

import com.didan.forum.users.dto.SendMailWithTemplate;
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
import com.didan.forum.users.repository.UserRepository;
import com.didan.forum.users.service.IKeycloakUserService;
import com.didan.forum.users.service.IRestTemplateService;
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
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;

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
  private final IRestTemplateService restTemplateService;
  private final RestTemplate restTemplate;

  @Value("${minio.bucket-name}")
  private String bucketName;

  @Value("${minio.endpoint}")
  private String minioEndpoint;

  @Value("${sendgrid.urlAuth}")
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

    UserResponseDto userResponseDto = keycloakUserService.createUserInKeycloak(requestDto, null,
        null, isVerified);

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
      String messageAuthUrl = urlAuth + token;
      objectMail.setMessage(messageAuthUrl);
      log.info("Sending Communication request to Kafka for the details : {}", objectMail);
      boolean isSendKafka = streamBridge.send("sendUserRegister-out-0", objectMail);
      log.info("Is the Communication request successfully triggered ? : {}", isSendKafka);
    }
    return MapperUtils.map(user, UserResponseDto.class);
  }

  @Override
  public UserResponseDto updateUser(String userId, UpdateUserRequestDto requestDto) {
    UserEntity userEntity = userRepository.findById(userId)
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

    userEntity = MapperUtils.map(updateUserRequest, UserEntity.class);
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
}
