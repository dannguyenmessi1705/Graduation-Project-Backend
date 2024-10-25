package com.didan.forum.users.controller.impl;

import com.didan.forum.users.controller.IKeycloakRoleController;
import com.didan.forum.users.dto.Status;
import com.didan.forum.users.dto.request.AddRoleToUserDto;
import com.didan.forum.users.dto.request.CreateNewRoleDto;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.entity.keycloak.RoleKeycloakEntity;
import com.didan.forum.users.service.IKeycloakRoleService;
import jakarta.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@Slf4j
public class KeycloakRoleControllerImpl implements IKeycloakRoleController {

  private final IKeycloakRoleService keycloakRoleService;

  @Override
  public ResponseEntity<GeneralResponse<List<RoleKeycloakEntity>>> getAllRolesOfUserFromKeycloak(
      String userId, HttpServletRequest request) {
    log.info("===== Start getting all roles of user from Keycloak =====");
    List<RoleKeycloakEntity> roles = keycloakRoleService.getAllRolesOfUserFromKeycloak(userId);
    Status status = new Status(request.getRequestURI(), 200,
        "Roles retrieved successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, roles), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> addRoleToUserInKeycloak(
      AddRoleToUserDto requestDto, HttpServletRequest request) {
    log.info("===== Start adding role to user in Keycloak =====");
    keycloakRoleService.addRoleToUserInKeycloak(requestDto.getUserId(), requestDto.getRoleName());
    Status status = new Status(request.getRequestURI(), 200,
        "Role added successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> removeRoleFromUserInKeycloak(
      AddRoleToUserDto requestDto, HttpServletRequest request) {
    log.info("===== Start removing role from user in Keycloak =====");
    keycloakRoleService.removeRoleFromUserInKeycloak(requestDto.getUserId(),
        requestDto.getRoleName());
    Status status = new Status(request.getRequestURI(), 200,
        "Role removed successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<List<RoleKeycloakEntity>>> getAllRolesFromKeycloak(HttpServletRequest request) {
    log.info("===== Start getting all roles from Keycloak =====");
    List<RoleKeycloakEntity> roles = keycloakRoleService.getAllRolesFromKeycloak();
    Status status = new Status(request.getRequestURI(), 200,
        "Roles retrieved successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, roles), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<RoleKeycloakEntity>> getRoleFromKeycloak(String roleName,
      HttpServletRequest request) {
    log.info("===== Start getting role from Keycloak =====");
    RoleKeycloakEntity role = keycloakRoleService.getRoleFromKeycloak(roleName);
    Status status = new Status(request.getRequestURI(), 200,
        "Role retrieved successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, role), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> createRoleInKeycloak(CreateNewRoleDto role, HttpServletRequest request) {
    log.info("===== Start creating role in Keycloak =====");
    keycloakRoleService.createRoleInKeycloak(role);
    Status status = new Status(request.getRequestURI(), 200,
        "Role created successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> deleteRoleFromKeycloak(String roleName, HttpServletRequest request) {
    log.info("===== Start deleting role from Keycloak =====");
    keycloakRoleService.deleteRoleFromKeycloak(roleName);
    Status status = new Status(request.getRequestURI(), 200,
        "Role deleted successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }
}
