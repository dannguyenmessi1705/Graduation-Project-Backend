package com.didan.forum.users.repository.user;

import com.didan.forum.users.entity.user.RoleEntity;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RoleRepository extends JpaRepository<RoleEntity, String> {

  Optional<RoleEntity> findRoleEntityByName(String name);
}
