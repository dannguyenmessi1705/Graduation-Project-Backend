package com.didan.forum.users.service;

import com.didan.forum.users.entity.RoleEntity;
import java.util.List;

public interface IKeycloakRoleService {

  List<RoleEntity> getAllRolesOfUserFromKeycloak(String userId);

  void addRoleToUserInKeycloak(String userId, String roleName);

  List<RoleEntity> getAllRolesFromKeycloak();

  RoleEntity getRoleFromKeycloak(String roleName);

  void createRoleInKeycloak(RoleEntity role);

  void updateRoleInKeycloak(RoleEntity role);

  void deleteRoleFromKeycloak(String roleName);
}