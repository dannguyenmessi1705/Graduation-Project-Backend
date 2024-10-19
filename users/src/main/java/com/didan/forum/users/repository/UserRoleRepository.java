package com.didan.forum.users.repository;

import com.didan.forum.users.entity.UserRoleEntity;
import com.didan.forum.users.entity.key.UserRoleId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRoleRepository extends JpaRepository<UserRoleEntity, UserRoleId> {

}
