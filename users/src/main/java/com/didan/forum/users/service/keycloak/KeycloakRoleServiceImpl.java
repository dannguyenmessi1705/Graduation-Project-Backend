package com.didan.forum.users.service.keycloak;

import com.didan.forum.users.dto.request.CreateNewRoleDto;
import com.didan.forum.users.entity.RoleEntity;
import com.didan.forum.users.entity.keycloak.RoleKeycloakEntity;
import com.didan.forum.users.exception.ResourceAlreadyExistException;
import com.didan.forum.users.exception.ResourceNotFoundException;
import com.didan.forum.users.process.SyncRoleWithKeycloak;
import com.didan.forum.users.service.IKeycloakRoleService;
import com.didan.forum.users.service.IRoleService;
import com.didan.forum.users.utils.MapperObjectKeycloakUtils;
import com.didan.forum.users.utils.MapperUtils;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.resource.RoleResource;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class KeycloakRoleServiceImpl implements IKeycloakRoleService {

  @Value("${keycloak.management-user.realm}")
  private String realm;

  private final Keycloak keycloak;
  private final IRoleService roleService;
  private final SyncRoleWithKeycloak syncRoleWithKeycloak;

  @Override
  public List<RoleKeycloakEntity> getAllRolesOfUserFromKeycloak(String userId) {
    UserResource userResource = checkUserExistence(userId);
    return MapperObjectKeycloakUtils.mapRoles(userResource.roles().realmLevel().listAll());
  }

  @Override
  public void addRoleToUserInKeycloak(String userId, String roleName) {
    roleService.assignRoleToUser(userId, roleName);
    RoleResource roleResource = checkRoleExistence(roleName);
    RoleRepresentation role = roleResource.toRepresentation();
    UserResource userResource = checkUserExistence(userId);
    userResource.roles().realmLevel().add(Collections.singletonList(role));
  }

  @Override
  public void removeRoleFromUserInKeycloak(String userId, String roleName) {
    roleService.removeRoleFromUser(userId, roleName);
    RoleResource roleResource = checkRoleExistence(roleName);
    RoleRepresentation role = roleResource.toRepresentation();
    UserResource userResource = checkUserExistence(userId);
    userResource.roles().realmLevel().remove(Collections.singletonList(role));
  }

  @Override
  public List<RoleKeycloakEntity> getAllRolesFromKeycloak() {
    List<RoleRepresentation> roleRepresentations =
        keycloak.realm(realm).roles().list();
    return MapperObjectKeycloakUtils.mapRoles(roleRepresentations);
  }

  @Override
  public RoleKeycloakEntity getRoleFromKeycloak(String roleName) {
    RoleResource roleResource = checkRoleExistence(roleName);
    return MapperObjectKeycloakUtils.mapRole(roleResource.toRepresentation());
  }

  @Override
  public void createRoleInKeycloak(CreateNewRoleDto role) {
    RoleResource roleResource = keycloak.realm(realm).roles().get(role.getName());
    try {
      RoleRepresentation roleRepresentation = roleResource.toRepresentation();
      if (roleRepresentation != null) {
        throw new ResourceAlreadyExistException(
            "Role with name " + role.getName() + " already exists in Keycloak");
      }
    } catch (Exception e) {
      if (e instanceof ResourceAlreadyExistException) {
        log.debug("Role with name {} not found in Keycloak", role.getName());
        throw new ResourceAlreadyExistException(
            "Role with name " + role.getName() + " already exists in Keycloak");
      }
      RoleKeycloakEntity roleEntity = new RoleKeycloakEntity(UUID.randomUUID().toString(),
          role.getName());
      RoleRepresentation roleRep = MapperObjectKeycloakUtils.mapRoleRep(roleEntity);
      keycloak.realm(realm).roles().create(roleRep);
      roleService.createRole(MapperUtils.map(roleEntity, RoleEntity.class));
      syncRoleWithKeycloak.evictCache();
    }
  }

  @Override
  public void deleteRoleFromKeycloak(String roleName) {
    RoleResource roleResource = checkRoleExistence(roleName);
    roleResource.remove();
    roleService.deleteRole(roleName);
    syncRoleWithKeycloak.evictCache();
  }

  private RoleResource checkRoleExistence(String roleName) {
    RoleResource roleResource = keycloak.realm(realm).roles().get(roleName);
    try {
      RoleRepresentation roleRepresentation = roleResource.toRepresentation();
    } catch (Exception e) {
      log.debug("Role with name {} not found in Keycloak", roleName);
      throw new ResourceNotFoundException("Role with name " + roleName + " not found in Keycloak");
    }
    return roleResource;
  }

  private UserResource checkUserExistence(String userId) {
    UserResource userResource = keycloak.realm(realm).users().get(userId);
    try {
      UserRepresentation userRepresentation = userResource.toRepresentation();
    } catch (Exception e) {
      log.debug("User with id {} not found in Keycloak", userId);
      throw new ResourceNotFoundException("User with id " + userId + " not found in Keycloak");
    }
    return userResource;
  }

}
