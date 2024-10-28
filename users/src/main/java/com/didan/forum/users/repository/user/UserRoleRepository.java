package com.didan.forum.users.repository.user;

import com.didan.forum.users.entity.user.UserRoleEntity;
import com.didan.forum.users.entity.key.UserRoleId;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRoleRepository extends JpaRepository<UserRoleEntity, UserRoleId> {

  List<UserRoleEntity> findUserRoleEntityByUser_Id(String userId);
}
