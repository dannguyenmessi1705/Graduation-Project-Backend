package com.didan.forum.users.entity.keycloak;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
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
  @Pattern(regexp = "^(user|admin|inactive|guest|banned)$", message = "invalid.field.roleName")
  private String name;
}
