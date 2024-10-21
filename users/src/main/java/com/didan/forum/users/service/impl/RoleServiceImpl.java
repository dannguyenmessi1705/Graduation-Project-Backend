package com.didan.forum.users.service.impl;

import com.didan.forum.users.entity.RoleEntity;
import com.didan.forum.users.entity.UserRoleEntity;
import com.didan.forum.users.entity.key.UserRoleId;
import com.didan.forum.users.exception.ResourceAlreadyExistException;
import com.didan.forum.users.exception.ResourceNotFoundException;
import com.didan.forum.users.repository.RoleRepository;
import com.didan.forum.users.repository.UserRoleRepository;
import com.didan.forum.users.service.IRoleService;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class RoleServiceImpl implements IRoleService {

  private final RoleRepository roleRepository;
  private final UserRoleRepository userRoleRepository;

  @Override
  public List<RoleEntity> queryRolesOfUser(String userId) {
    List<UserRoleEntity> userRoleEntities =
        userRoleRepository.findUserRoleEntityByUser_Id(userId);
    List<String> roleIds = userRoleEntities.stream().map(r -> r.getRole().getId())
        .collect(Collectors.toList());
    return roleRepository.findAllById(roleIds);
  }

  @Override
  public RoleEntity createRole(RoleEntity roleEntity) {
    roleRepository.findRoleEntityByName(roleEntity.getName())
        .ifPresent(r -> {
          throw new IllegalArgumentException("Role already exists");
        });
    return roleRepository.save(roleEntity);
  }

  @Override
  public void assignRoleToUser(String userId, String roleName) {
    List<UserRoleEntity> userRoleEntities =
        userRoleRepository.findUserRoleEntityByUser_Id(userId);
    RoleEntity roleEntity = roleRepository.findRoleEntityByName(roleName)
        .orElseThrow(() -> new IllegalArgumentException("Role not found"));
    if (userRoleEntities.stream().anyMatch(r -> r.getRole().getId().equals(roleEntity.getId()))) {
      throw new ResourceAlreadyExistException("Role already assigned to user");
    } else {
      UserRoleEntity userRoleEntity = new UserRoleEntity();
      userRoleEntity.setId(new UserRoleId(userId, roleEntity.getId()));
      userRoleRepository.save(userRoleEntity);
    }
  }

  @Override
  public void removeRoleFromUser(String userId, String roleName) {
    List<UserRoleEntity> userRoleEntities =
        userRoleRepository.findUserRoleEntityByUser_Id(userId);
    RoleEntity roleEntity = roleRepository.findRoleEntityByName(roleName)
        .orElseThrow(() -> new IllegalArgumentException("Role not found"));
    userRoleEntities.stream()
        .filter(r -> r.getRole().getId().equals(roleEntity.getId()))
        .findFirst()
        .ifPresentOrElse(userRoleRepository::delete, () -> {
          throw new ResourceNotFoundException("Role not assigned to user");
        });
  }

  @Override
  public void deleteRole(String roleName) {
    RoleEntity roleEntity = roleRepository.findRoleEntityByName(roleName)
        .orElseThrow(() -> new IllegalArgumentException("Role not found"));
    roleRepository.delete(roleEntity);
  }
}
