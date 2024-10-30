package com.didan.forum.users.entity.user;

import com.didan.forum.users.entity.SuperClass;
import com.didan.forum.users.entity.key.UserRoleId;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "user_role")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class UserRoleEntity extends SuperClass implements Serializable {
  @EmbeddedId
  private UserRoleId id;

  @ManyToOne
  @JoinColumn(name = "user_id", insertable = false, updatable = false)
  @JsonBackReference
  private UserEntity user;

  @ManyToOne
  @JoinColumn(name = "role_id", insertable = false, updatable = false)
  @JsonBackReference
  private RoleEntity role;
}
