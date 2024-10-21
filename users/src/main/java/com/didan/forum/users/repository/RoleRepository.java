package com.didan.forum.users.repository;

import com.didan.forum.users.entity.RoleEntity;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<RoleEntity, String> {

  Optional<RoleEntity> findRoleEntityByName(String name);
}
