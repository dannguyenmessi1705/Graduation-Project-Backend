package com.didan.forum.users.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ChangePasswordAdminDto {

  @NotBlank(message = "blank.field.password")
  @Size(min = 8, message = "invalid.field.password")
  private String password;
}
