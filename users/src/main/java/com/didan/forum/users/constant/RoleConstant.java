package com.didan.forum.users.constant;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public enum RoleConstant {
  ROLE_USER("user", "User can access the forum"),
  ROLE_ADMIN("admin", "Has access to all the resources"),
  ROLE_INACTIVE("inactive",
      "Registered but has not activated the account, so cannot access the forum"),
  ROLE_GUEST("guest", "Not registered, can only access the public resources"),
  ROLE_BANNED("banned", "Cannot access the forum");

  private String role;
  private String description;

  RoleConstant(String role, String description) {
    this.role = role;
    this.description = description;
  }


}
