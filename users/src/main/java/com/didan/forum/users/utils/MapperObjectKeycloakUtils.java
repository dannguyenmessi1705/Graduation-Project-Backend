package com.didan.forum.users.utils;

import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import com.didan.forum.users.entity.keycloak.RoleKeycloakEntity;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.keycloak.common.util.CollectionUtil;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.util.StringUtils;

public class MapperObjectKeycloakUtils {

  public static List<RoleKeycloakEntity> mapRoles(List<RoleRepresentation> representations) {
    List<RoleKeycloakEntity> roles = new ArrayList<>();
    if (CollectionUtil.isNotEmpty(representations)) {
      representations.forEach(roleRep -> roles.add(mapRole(roleRep)));
    }
    return roles;
  }

  public static RoleKeycloakEntity mapRole(RoleRepresentation roleRep) {
    RoleKeycloakEntity role = new RoleKeycloakEntity();
    role.setId(roleRep.getId());
    role.setName(roleRep.getName());
    return role;
  }

  public static RoleRepresentation mapRoleRep(RoleKeycloakEntity role) {
    RoleRepresentation roleRep = new RoleRepresentation();
    roleRep.setName(role.getName());
    return roleRep;
  }

  public static List<UserResponseDto> mapUsers(List<UserRepresentation> userReps) {
    List<UserResponseDto> users = new ArrayList<>();
    if (CollectionUtil.isNotEmpty(userReps)) {
      userReps.forEach(userRep -> {
        users.add(mapUser(userRep));
      });
    }
    return users;
  }

  public static UserResponseDto mapUser(UserRepresentation userRep) {
    UserResponseDto user = new UserResponseDto();
    user.setId(userRep.getId());
    user.setFirstName(userRep.getFirstName());
    user.setLastName(userRep.getLastName());
    user.setEmail(userRep.getEmail());
    user.setUsername(userRep.getUsername());
    user.setVerified(userRep.isEmailVerified());
    Map<String, List<String>> attributes = userRep.getAttributes();
    for (Map.Entry<String, List<String>> entry : attributes.entrySet()) {
      switch (entry.getKey()) {
        case "birthday":
          user.setBirthDay(LocalDate.parse(entry.getValue().getFirst()));
          break;
        case "country":
          user.setCountry(entry.getValue().getFirst());
          break;
        case "city":
          user.setCity(entry.getValue().getFirst());
          break;
        case "phoneNumber":
          user.setPhoneNumber(entry.getValue().getFirst());
          break;
        case "gender":
          user.setGender(entry.getValue().getFirst());
          break;
        case "postalCode":
          user.setPostalCode(Long.parseLong(entry.getValue().getFirst()));
          break;
        case "picture":
          user.setPicture(entry.getValue().getFirst());
          break;
        default:
          break;
      }
    }
    return user;
  }

  public static UserRepresentation mapUserRep(String userId,
      boolean isVerified, String pictureUrl, CreateUserRequestDto user) {
    UserRepresentation userRep = new UserRepresentation();
    userRep.setId(userId);
    userRep.setUsername(user.getUsername());
    userRep.setFirstName(user.getFirstName());
    userRep.setLastName(user.getLastName());
    userRep.setEmail(user.getEmail());
    userRep.setEnabled(true);
    userRep.setEmailVerified(isVerified);

    Map<String, List<String>> attributes = new HashMap<>();
    attributes.put("birthday", List.of(user.getBirthDay().toString()));
    attributes.put("country", List.of(user.getCountry()));
    attributes.put("city", List.of(user.getCity()));
    attributes.put("phoneNumber", List.of(user.getPhoneNumber()));
    attributes.put("postalCode", List.of(user.getPostalCode().toString()));
    attributes.put("gender", List.of(user.getGender()));
    attributes.put("picture", StringUtils.hasText(pictureUrl) ? List.of(pictureUrl) : null);
    userRep.setAttributes(attributes);

    List<CredentialRepresentation> creds = new ArrayList<>();
    CredentialRepresentation cred = new CredentialRepresentation();
    cred.setTemporary(false);
    cred.setValue(user.getPassword());
    creds.add(cred);
    userRep.setCredentials(creds);
    return userRep;
  }
}
