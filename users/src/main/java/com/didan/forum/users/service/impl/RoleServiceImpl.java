package com.didan.forum.users.service.impl;

import com.didan.forum.users.entity.user.RoleEntity;
import com.didan.forum.users.entity.user.UserEntity;
import com.didan.forum.users.entity.user.UserRoleEntity;
import com.didan.forum.users.exception.ResourceAlreadyExistException;
import com.didan.forum.users.exception.ResourceNotFoundException;
import com.didan.forum.users.repository.user.RoleRepository;
import com.didan.forum.users.repository.user.UserRepository;
import com.didan.forum.users.repository.user.UserRoleRepository;
import com.didan.forum.users.service.IRoleService;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Slf4j
public class RoleServiceImpl implements IRoleService {

  private final RoleRepository roleRepository;
  private final UserRepository userRepository;
  private final UserRoleRepository userRoleRepository;

  @Override
  public List<RoleEntity> queryRolesOfUser(String userId) {
    List<UserRoleEntity> userRoleEntities =
        userRoleRepository.findUserRoleEntitiesByUserId(userId);
    log.info("User role entities: {}", userRoleEntities);
    List<String> roleIds = userRoleEntities.stream().map(r -> {
          log.info("Role id: {}", r.getRoleId());
          return r.getRoleId();
        })
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
        userRoleRepository.findUserRoleEntitiesByUserId(userId);
    RoleEntity roleEntity = roleRepository.findRoleEntityByName(roleName)
        .orElseThrow(() -> new IllegalArgumentException("Role not found"));
    if (userRoleEntities.stream().anyMatch(r -> r.getRoleId().equals(roleEntity.getId()))) {
      throw new ResourceAlreadyExistException("Role already assigned to user");
    } else {
      UserEntity user = userRepository.findById(userId)
          .orElseThrow(() -> new ResourceNotFoundException("User not found"));
      UserRoleEntity userRoleEntity = new UserRoleEntity();
      userRoleEntity.setRoleId(roleEntity.getId());
      userRoleEntity.setUserId(userId);
      userRoleRepository.save(userRoleEntity);
    }
  }

  @Override
  public void removeRoleFromUser(String userId, String roleName) {
    RoleEntity roleEntity = roleRepository.findRoleEntityByName(roleName)
        .orElseThrow(() -> new IllegalArgumentException("Role not found"));
    UserRoleEntity userRoleEntity = userRoleRepository
        .findUserRoleEntityByUserIdAndRoleId(userId, roleEntity.getId())
        .orElseThrow(() -> new ResourceNotFoundException("Role not assigned to user"));
    log.info("Delete user role: {}", userRoleEntity.getId());
    userRoleRepository.deleteUserRoleEntityById(userRoleEntity.getId());
    log.info("Deleted user role: {}", userRoleEntity.getId());
  }

  @Override
  @Transactional
  @Modifying
  public void deleteRole(String roleName) {
    RoleEntity roleEntity = roleRepository.findRoleEntityByName(roleName)
        .orElseThrow(() -> new IllegalArgumentException("Role not found"));
    roleRepository.delete(roleEntity);
  }
}
