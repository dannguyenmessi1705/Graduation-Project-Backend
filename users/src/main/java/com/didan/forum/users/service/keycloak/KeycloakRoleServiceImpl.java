package com.didan.forum.users.service.keycloak;

import com.didan.forum.users.entity.RoleEntity;
import com.didan.forum.users.service.IKeycloakRoleService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.keycloak.admin.client.Keycloak;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class KeycloakRoleServiceImpl implements IKeycloakRoleService {

  @Value("${keycloak.management-user.realm}")
  private String realm;

  private final Keycloak keycloak;

  @Override
  public List<RoleEntity> getAllRolesOfUserFromKeycloak(String userId) {
    return List.of();
  }

  @Override
  public void addRoleToUserInKeycloak(String userId, String roleName) {

  }

  @Override
  public List<RoleEntity> getAllRolesFromKeycloak() {
    return List.of();
  }

  @Override
  public RoleEntity getRoleFromKeycloak(String roleName) {
    return null;
  }

  @Override
  public void createRoleInKeycloak(RoleEntity role) {

  }

  @Override
  public void updateRoleInKeycloak(RoleEntity role) {

  }

  @Override
  public void deleteRoleFromKeycloak(String roleName) {

  }
}
