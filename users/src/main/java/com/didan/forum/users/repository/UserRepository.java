package com.didan.forum.users.repository;

import com.didan.forum.users.entity.UserEntity;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, String> {
  Optional<UserEntity> findFirstByEmailIgnoreCase(String email);
  Optional<UserEntity> findFirstByUsernameIgnoreCase(String username);
  Optional<UserEntity> findFirstByPhoneNumber(String phoneNumber);
}
