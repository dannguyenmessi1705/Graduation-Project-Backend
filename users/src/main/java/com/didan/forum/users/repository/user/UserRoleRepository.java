package com.didan.forum.users.repository.user;

import com.didan.forum.users.entity.user.RoleEntity;
import com.didan.forum.users.entity.user.UserEntity;
import com.didan.forum.users.entity.user.UserRoleEntity;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface UserRoleRepository extends JpaRepository<UserRoleEntity, Long> {

  List<UserRoleEntity> findUserRoleEntitiesByUserId(String userId);

  Optional<UserRoleEntity> findUserRoleEntityByUserIdAndRoleId(String userId, String roleId);

  @Modifying
  @Transactional
  void deleteUserRoleEntityById(Long id);
}
