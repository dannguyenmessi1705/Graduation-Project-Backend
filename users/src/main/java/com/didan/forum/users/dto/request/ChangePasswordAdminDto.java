package com.didan.forum.users.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class ChangePasswordAdminDto {

  @NotBlank(message = "blank.field.password")
  @Size(min = 8, message = "invalid.field.password")
  private String password;
}
