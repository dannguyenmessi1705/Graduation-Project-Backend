package com.didan.forum.users.service.keycloak;

import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.request.UpdateUserRequestDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import com.didan.forum.users.exception.ErrorActionException;
import com.didan.forum.users.exception.ResourceNotFoundException;
import com.didan.forum.users.service.IKeycloakUserService;
import com.didan.forum.users.service.minio.MinioService;
import com.didan.forum.users.utils.MapperObjectKeycloakUtils;
import com.didan.forum.users.utils.MapperUtils;
import jakarta.ws.rs.core.Response;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
@Slf4j
@RequiredArgsConstructor
public class KeycloakUserServiceImpl implements IKeycloakUserService {

  @Value("${keycloak.management-user.realm}")
  private String realm;

  @Value("${minio.bucket-name}")
  private String bucketName;

  private final Keycloak keycloak;
  private final MinioService minio;

  @Override
  public List<UserResponseDto> getAllUsersFromKeycloak() {
    List<UserRepresentation> userReps = keycloak.realm(realm).users().list();
    if (userReps.isEmpty()) {
      log.debug("No users found in Keycloak");
      throw new ResourceNotFoundException("No users found in Keycloak");
    }
    return MapperObjectKeycloakUtils.mapUsers(userReps);
  }

  @Override
  public UserResponseDto getUserDetailsFromKeycloak(String userId) {
    UserRepresentation userRep = keycloak.realm(realm).users().get(userId).toRepresentation();
    if (userRep == null) {
      log.debug("User with id {} not found in Keycloak", userId);
      throw new ResourceNotFoundException("User with id " + userId + " not found in Keycloak");
    }
    return MapperObjectKeycloakUtils.mapUser(userRep);
  }

  @Override
  public UserResponseDto createUserInKeycloak(CreateUserRequestDto requestDto, String userId,
      String picture, boolean isVerified) {
    log.info(requestDto.getBirthDay().toString());
    if ((!requestDto.getPicture().isEmpty() || requestDto.getPicture() != null)
        && picture == null) {
      log.info("Uploading avatar to Minio");
      minio.createBucket(bucketName);
      String fileName = requestDto.getPicture().getOriginalFilename();
      if (!StringUtils.hasText(fileName)) {
        throw new ErrorActionException("File name is empty");
      }
      picture = "avatar_" + userId + "." + fileName.split("\\.")[1];
      String contentType = requestDto.getPicture().getContentType();
      minio.uploadFile(bucketName, requestDto.getPicture(), picture, contentType);
      log.info("Avatar uploaded successfully");
    }

    UserRepresentation userRep = MapperObjectKeycloakUtils.mapUserRep(userId, isVerified, picture,
        requestDto);
    try {
      Response res = keycloak.realm(realm).users().create(userRep);
      if (res.getStatus() == 201) {
        log.info("User created successfully in Keycloak");
      } else {
        log.error("Error creating user in Keycloak: {}", res.getStatusInfo().getReasonPhrase());
        throw new ErrorActionException("Error creating user in Keycloak: " + res.getStatusInfo()
            .getReasonPhrase());
      }
    } catch (Exception e) {
      log.error("Error creating user in Keycloak: {}", e.getMessage());
      throw new ErrorActionException("Error creating user in Keycloak: " + e.getMessage());
    }
    UserRepresentation userRes =
        keycloak.realm(realm).users().search(requestDto.getUsername()).getFirst();
    return MapperObjectKeycloakUtils.mapUser(userRes);
  }

  @Override
  public UserResponseDto updateUserInKeycloak(String userId, UpdateUserRequestDto requestDto) {
    UserResource userResource = keycloak.realm(realm).users().get(userId);
    if (userResource == null) {
      log.debug("User with id {} not found in Keycloak", userId);
      throw new ResourceNotFoundException("User with id " + userId + " not found in Keycloak");
    }
    UserResponseDto updateUser = MapperObjectKeycloakUtils.mapUser(userResource.toRepresentation());
    if (StringUtils.hasText(requestDto.getCity())) {
      updateUser.setCity(requestDto.getCity());
    }
    if (StringUtils.hasText(requestDto.getCountry())) {
      updateUser.setCountry(requestDto.getCountry());
    }
    if (StringUtils.hasText(requestDto.getGender())) {
      updateUser.setGender(requestDto.getGender());
    }
    if (StringUtils.hasText(requestDto.getPhoneNumber())) {
      updateUser.setPhoneNumber(requestDto.getPhoneNumber());
    }
    if (requestDto.getPostalCode() != null) {
      updateUser.setPostalCode(requestDto.getPostalCode());
    }
    if (requestDto.getBirthDay() != null) {
      updateUser.setBirthDay(requestDto.getBirthDay());
    }
    if (StringUtils.hasText(requestDto.getEmail())) {
      updateUser.setEmail(requestDto.getEmail());
    }
    if (StringUtils.hasText(requestDto.getFirstName())) {
      updateUser.setFirstName(requestDto.getFirstName());
    }
    if (StringUtils.hasText(requestDto.getLastName())) {
      updateUser.setLastName(requestDto.getLastName());
    }
    if (StringUtils.hasText(String.valueOf(requestDto.isVerified()))) {
      updateUser.setVerified(requestDto.isVerified());
    }

    if (!requestDto.getPicture().isEmpty() || requestDto.getPicture() != null) {
      log.info("Uploading avatar to Minio");
      minio.createBucket(bucketName);
      String fileName = requestDto.getPicture().getOriginalFilename();
      if (!StringUtils.hasText(fileName)) {
        throw new ErrorActionException("File name is empty");
      }
      String picture = "avatar_" + userId + "." + fileName.split("\\.")[1];
      String contentType = requestDto.getPicture().getContentType();
      minio.uploadFile(bucketName, requestDto.getPicture(), picture, contentType);
      log.info("Avatar uploaded successfully");
      updateUser.setPicture(picture);
    }
    UserRepresentation userRep = MapperObjectKeycloakUtils.mapUserRep(updateUser.getId(),
        updateUser.isVerified(), updateUser.getPicture(), MapperUtils.map(updateUser,
            CreateUserRequestDto.class));
    userResource.update(userRep);
    return updateUser;
  }

  @Override
  public void updateUserPasswordInKeycloak(String userId, String password) {
    UserResource userResource = keycloak.realm(realm).users().get(userId);
    if (userResource == null) {
      log.debug("User with id {} not found in Keycloak", userId);
      throw new ResourceNotFoundException("User with id " + userId + " not found in Keycloak");
    }
    if (password.length() < 8) {
      log.debug("Password must be at least 8 characters long");
      throw new ErrorActionException("Password must be at least 8 characters long");
    }
    UserResponseDto user = MapperObjectKeycloakUtils.mapUser(userResource.toRepresentation());
    CreateUserRequestDto userDto = MapperUtils.map(user, CreateUserRequestDto.class);
    userDto.setPassword(password);
    UserRepresentation userRep = MapperObjectKeycloakUtils.mapUserRep(user.getId(),
        user.isVerified(), user.getPicture(), userDto);
    userResource.update(userRep);
  }

  @Override
  public void deleteUserFromKeycloak(String userId) {
    UserResource userResource = keycloak.realm(realm).users().get(userId);
    if (userResource == null) {
      log.debug("User with id {} not found in Keycloak", userId);
      throw new ResourceNotFoundException("User with id " + userId + " not found in Keycloak");
    }
    userResource.remove();
  }
}
