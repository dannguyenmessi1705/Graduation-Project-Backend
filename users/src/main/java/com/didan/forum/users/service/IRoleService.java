package com.didan.forum.users.service;

import com.didan.forum.users.entity.RoleEntity;
import java.util.List;

public interface IRoleService {

  List<RoleEntity> queryRolesOfUser(String userId);

  RoleEntity createRole(RoleEntity roleEntity);

  void assignRoleToUser(String userId, String roleName);

  void removeRoleFromUser(String userId, String roleName);

  void deleteRole(String roleName);
}
