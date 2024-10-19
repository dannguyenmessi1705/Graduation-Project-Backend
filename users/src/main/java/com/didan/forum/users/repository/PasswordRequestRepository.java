package com.didan.forum.users.repository;

import com.didan.forum.users.entity.PasswordRequestEntity;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PasswordRequestRepository extends JpaRepository<PasswordRequestEntity, String> {
  Optional<PasswordRequestEntity> findPasswordRequestEntitiesByUser_Id(String userId);
  Optional<PasswordRequestEntity> findPasswordRequestEntitiesByToken(String token);
}
