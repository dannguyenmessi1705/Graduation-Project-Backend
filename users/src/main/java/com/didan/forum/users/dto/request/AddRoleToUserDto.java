package com.didan.forum.users.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddRoleToUserDto {

  @NotBlank(message = "blank.field.userid")
  private String userId;

  @NotBlank(message = "blank.field.roleName")
  private String roleName;
}
