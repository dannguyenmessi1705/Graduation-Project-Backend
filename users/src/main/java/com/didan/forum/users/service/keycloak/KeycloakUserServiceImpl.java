package com.didan.forum.users.service.keycloak;

import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.request.UpdateUserAdminRequestDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import com.didan.forum.users.exception.ErrorActionException;
import com.didan.forum.users.exception.ResourceNotFoundException;
import com.didan.forum.users.service.IKeycloakUserService;
import com.didan.forum.users.service.minio.MinioService;
import com.didan.forum.users.utils.ImageGenerator;
import com.didan.forum.users.utils.MapperObjectKeycloakUtils;
import com.didan.forum.users.utils.MapperUtils;
import jakarta.ws.rs.core.Response;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
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
    try {
      UserRepresentation userRep = keycloak.realm(realm).users().get(userId).toRepresentation();
      return MapperObjectKeycloakUtils.mapUser(userRep);
    } catch (Exception e) {
      log.debug("User with id {} not found in Keycloak", userId);
      throw new ResourceNotFoundException("User with id " + userId + " not found in Keycloak");
    }
  }

  @Override
  public UserResponseDto createUserInKeycloak(CreateUserRequestDto requestDto,
   String pictureUrl, boolean isVerified) {
    UserRepresentation userRep = MapperObjectKeycloakUtils.mapUserRep(null, isVerified, pictureUrl,
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
  public UserResponseDto updateUserInKeycloak(String userId, UpdateUserAdminRequestDto requestDto) {
    try {
      UserResource userResource = keycloak.realm(realm).users().get(userId);
      UserResponseDto updateUser = MapperObjectKeycloakUtils.mapUser(
          userResource.toRepresentation());
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

      if (requestDto.getPicture() != null) {
        log.info("Uploading avatar to Minio");
        minio.createBucket(bucketName);
        String fileName = requestDto.getPicture().getOriginalFilename();
        if (!StringUtils.hasText(fileName)) {
          throw new ErrorActionException("File name is empty");
        }
        String picturePath = "avatar_" + updateUser.getUsername() + "." + fileName.split("\\.")[1];
        String contentType = requestDto.getPicture().getContentType();
        minio.uploadFile(bucketName, requestDto.getPicture(), picturePath, contentType);
        log.info("Avatar uploaded successfully");
        String pictureUrl = minio.getUTF8ByURLDecoder(minio.getPresignedObjectUrl(bucketName,
            picturePath));
        updateUser.setPicture(pictureUrl);
      }
      UserRepresentation userRep = MapperObjectKeycloakUtils.mapUserRep(updateUser.getId(),
          updateUser.isVerified(), updateUser.getPicture(), MapperUtils.map(updateUser,
              CreateUserRequestDto.class));
      userResource.update(userRep);
      return updateUser;
    } catch (Exception e) {
      log.debug("User with id {} not found in Keycloak", userId);
      throw new ResourceNotFoundException("User with id " + userId + " not found in Keycloak");
    }
  }

  @Override
  public void updateUserPasswordInKeycloak(String userId, String password) {
    try {
      UserResource userResource = keycloak.realm(realm).users().get(userId);
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
    } catch (Exception e) {
      if (e instanceof ErrorActionException) {
        throw new ErrorActionException(e.getMessage());
      }
      log.debug("User with id {} not found in Keycloak", userId);
      throw new ResourceNotFoundException("User with id " + userId + " not found in Keycloak");
    }
  }

  @Override
  public void deleteUserFromKeycloak(String userId) {
    try {
      UserResource userResource = keycloak.realm(realm).users().get(userId);
      userResource.remove();
    } catch (Exception e) {
      log.debug("User with id {} not found in Keycloak", userId);
      throw new ResourceNotFoundException("User with id " + userId + " not found in Keycloak");
    }
  }
}
