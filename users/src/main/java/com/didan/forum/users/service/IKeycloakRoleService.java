package com.didan.forum.users.service;

import com.didan.forum.users.dto.request.CreateNewRoleDto;
import com.didan.forum.users.entity.keycloak.RoleKeycloakEntity;
import java.util.List;

public interface IKeycloakRoleService {

  List<RoleKeycloakEntity> getAllRolesOfUserFromKeycloak(String userId);

  void addRoleToUserInKeycloak(String userId, String roleName);

  void removeRoleFromUserInKeycloak(String userId, String roleName);

  List<RoleKeycloakEntity> getAllRolesFromKeycloak();

  RoleKeycloakEntity getRoleFromKeycloak(String roleName);

  void createRoleInKeycloak(CreateNewRoleDto role);

  void deleteRoleFromKeycloak(String roleName);
}