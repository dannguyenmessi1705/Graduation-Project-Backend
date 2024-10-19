package com.didan.forum.users.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChangePasswordUserDto {

  @Schema(
      name = "oldPassword",
      description = "User old password",
      example = "oldPassword"
  )
  @NotBlank(message = "blank.field.password")
  private String oldPassword;

  @Schema(
      name = "newPassword",
      description = "User new password",
      example = "newPassword"
  )
  @Size(min = 8, message = "invalid.field.password")
  private String newPassword;
}
