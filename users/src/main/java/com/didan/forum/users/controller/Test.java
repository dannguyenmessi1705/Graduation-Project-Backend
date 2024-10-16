package com.didan.forum.users.controller;

import com.didan.forum.users.dto.RoleDto;
import com.didan.forum.users.dto.Status;
import com.didan.forum.users.dto.UserDto;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.config.locale.Translator;
import com.didan.forum.users.service.keycloak.KeycloakService;
import jakarta.ws.rs.core.Response;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.common.util.CollectionUtil;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class Test {
  private final MessageSource messageSource;
  private final KeycloakService keycloakService;

  @Value("${keycloak.management-user.realm}")
  private String realm;

  @GetMapping("/test")
  public ResponseEntity<GeneralResponse<String>> test() {
    String s = Translator.toLocale("method.argument.invalid", "");
    Status status = new Status("/test", 200, s, LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, "Hello World"), HttpStatus.OK);
  }

  @GetMapping("/users")
  public List<UserDto> getUsers() {
    Keycloak keycloak = keycloakService.getKeycloakInstance();
    List<UserRepresentation> userReps = keycloak.realm(realm).users().list();
    return mapUsers(userReps);
  }

  @PostMapping(value = "/user")
  public ResponseEntity<?> createUser(UserDto user) {
    UserRepresentation userRep = mapUserRep(user);
    Keycloak keycloak = keycloakService.getKeycloakInstance();
    Response res = keycloak.realm(realm).users().create(userRep);
    return ResponseEntity.ok(user);
  }

  @PutMapping(value = "/user")
  public ResponseEntity<?> updateUser(UserDto user) {
    UserRepresentation userRep = mapUserRep(user);
    Keycloak keycloak = keycloakService.getKeycloakInstance();
    keycloak.realm(realm).users().get(user.getId()).update(userRep);
    return ResponseEntity.ok(user);
  }

  @DeleteMapping(value = "/users/{id}")
  public ResponseEntity<?> deleteUser(@PathVariable("id") String id) {
    Keycloak keycloak = keycloakService.getKeycloakInstance();
    keycloak.realm(realm).users().delete(id);
    return ResponseEntity.ok().build();
  }

  @GetMapping(value = "/users/{id}/roles")
  public List<RoleDto> getRoles(@PathVariable("id") String id) {
    Keycloak keycloak = keycloakService.getKeycloakInstance();
    return mapRoles(keycloak.realm(realm).users()
        .get(id).roles().realmLevel().listAll());
  }

  @PostMapping(value = "/users/{id}/roles/{roleName}")
  public ResponseEntity<?> createRole(@PathVariable("id") String id,
      @PathVariable("roleName") String roleName) {
    Keycloak keycloak = keycloakService.getKeycloakInstance();
    RoleRepresentation role = keycloak.realm(realm).roles().get(roleName).toRepresentation();
    keycloak.realm(realm).users().get(id).roles().realmLevel().add(Arrays.asList(role));
    return ResponseEntity.ok().build();
  }

  @GetMapping(value = "/roles")
  public List<RoleDto> getRoles() {
    Keycloak keycloak = keycloakService.getKeycloakInstance();
    List<RoleRepresentation> roleRepresentations =
        keycloak.realm(realm).roles().list();
    return mapRoles(roleRepresentations);
  }

  @GetMapping(value = "/roles/{roleName}")
  public RoleDto getRole(@PathVariable("roleName") String roleName) {
    Keycloak keycloak = keycloakService.getKeycloakInstance();
    return mapRole(keycloak.realm(realm).roles().get(roleName).toRepresentation());
  }

  @PostMapping(value = "/role")
  public ResponseEntity<?> createRole(RoleDto role) {
    RoleRepresentation roleRep = mapRoleRep(role);
    Keycloak keycloak = keycloakService.getKeycloakInstance();
    keycloak.realm(realm).roles().create(roleRep);
    return ResponseEntity.ok(role);
  }

  @PutMapping(value = "/role")
  public ResponseEntity<?> updateRole(RoleDto role) {
    RoleRepresentation roleRep = mapRoleRep(role);
    Keycloak keycloak = keycloakService.getKeycloakInstance();
    keycloak.realm(realm).roles().get(role.getName()).update(roleRep);
    return ResponseEntity.ok(role);
  }

  @DeleteMapping(value = "/roles/{roleName}")
  public ResponseEntity deleteRole(@PathVariable("roleName") String roleName) {
    Keycloak keycloak = keycloakService.getKeycloakInstance();
    keycloak.realm(realm).roles().deleteRole(roleName);
    return ResponseEntity.ok().build();
  }

  public static List<RoleDto> mapRoles(List<RoleRepresentation> representations) {
    List<RoleDto> roles = new ArrayList<>();
    if(CollectionUtil.isNotEmpty(representations)) {
      representations.forEach(roleRep -> roles.add(mapRole(roleRep)));
    }
    return roles;
  }

  public static RoleDto mapRole(RoleRepresentation roleRep) {
    RoleDto role = new RoleDto();
    role.setId(roleRep.getId());
    role.setName(roleRep.getName());
    return role;
  }

  public RoleRepresentation mapRoleRep(RoleDto role) {
    RoleRepresentation roleRep = new RoleRepresentation();
    roleRep.setName(role.getName());
    return roleRep;
  }

  private List<UserDto> mapUsers(List<UserRepresentation> userReps) {
    List<UserDto> users = new ArrayList<>();
    if (CollectionUtil.isNotEmpty(userReps)) {
      userReps.forEach(userRep -> {
        users.add(mapUser(userRep));
      });
    }
    return users;
  }

  private UserDto mapUser(UserRepresentation userRep) {
    UserDto user = new UserDto();
    user.setId(userRep.getId());
    user.setFirstName(userRep.getFirstName());
    user.setLastName(userRep.getLastName());
    user.setEmail(userRep.getEmail());
    user.setUsername(userRep.getUsername());
    return user;
  }

  private UserRepresentation mapUserRep(UserDto user) {
    UserRepresentation userRep = new UserRepresentation();
    userRep.setId(user.getId());
    userRep.setUsername(user.getUsername());
    userRep.setFirstName(user.getFirstName());
    userRep.setLastName(user.getLastName());
    userRep.setEmail(user.getEmail());
    userRep.setEnabled(true);
    userRep.setEmailVerified(true);
    List<CredentialRepresentation> creds = new ArrayList<>();
    CredentialRepresentation cred = new CredentialRepresentation();
    cred.setTemporary(false);
    cred.setValue(user.getPassword());
    creds.add(cred);
    userRep.setCredentials(creds);
    return userRep;
  }

}
