package com.didan.forum.users.repository;

import com.didan.forum.users.entity.PasswordRequestEntity;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PasswordRequestRepository extends CrudRepository<PasswordRequestEntity, String> {
  Optional<PasswordRequestEntity> findPasswordRequestEntityByUserId(String userId);
  Optional<PasswordRequestEntity> findPasswordRequestEntitiesByToken(String token);
}
