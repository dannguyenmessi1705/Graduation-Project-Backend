package com.didan.forum.users.repository.user;

import com.didan.forum.users.entity.user.UserEntity;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, String> {
  Optional<UserEntity> findFirstByEmailIgnoreCase(String email);
  Optional<UserEntity> findFirstByUsernameIgnoreCase(String username);
  Optional<UserEntity> findFirstByPhoneNumber(String phoneNumber);
  List<UserEntity> findAllByUsernameContainingIgnoreCase(String username, Pageable pageable);

  @Query(value = "UPDATE user u SET u.isVerifie = ?2 WHERE u.id = ?1", nativeQuery = true)
  @Modifying
  @Transactional
  void updateByIdAndVerified(String id, boolean verified);
}
