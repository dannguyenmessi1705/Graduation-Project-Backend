package com.didan.forum.users.repository.user;

import com.didan.forum.users.entity.user.UserEntity;
import jakarta.persistence.Entity;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.EntityGraph.EntityGraphType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, String> {
  @EntityGraph(attributePaths = {"userRoles", "userRoles.role"},
      type = EntityGraphType.FETCH)
  Optional<UserEntity> findFirstByEmailIgnoreCase(String email);
  @EntityGraph(attributePaths = {"userRoles", "userRoles.role"},
      type = EntityGraphType.FETCH)
  Optional<UserEntity> findFirstByUsernameIgnoreCase(String username);
  @EntityGraph(attributePaths = {"userRoles", "userRoles.role"},
      type = EntityGraphType.FETCH)
  Optional<UserEntity> findFirstByPhoneNumber(String phoneNumber);
  @EntityGraph(attributePaths = {"userRoles", "userRoles.role"},
      type = EntityGraphType.FETCH)
  List<UserEntity> findAllByUsernameContainingIgnoreCase(String username, Pageable pageable);

  @Query(value = "UPDATE user u SET u.isVerified = ?2 WHERE u.id = ?1")
  @Modifying
  @Transactional
  void updateByIdAndVerified(String id, boolean verified);
}
