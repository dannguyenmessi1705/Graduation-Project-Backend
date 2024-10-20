package com.didan.forum.users.entity.keycloak;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class RoleKeycloakEntity {

  @NotBlank(message = "blank.field.roleId")
  private String id;
  @NotBlank(message = "blank.field.roleName")
  private String name;
}
