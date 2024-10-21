package com.didan.forum.users.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginRequestDto {

  @Schema(
      name = "username",
      description = "Username of the user",
      example = "test"
  )
  @NotBlank(message = "blank.field.username")
  private String username;

  @Schema(
      name = "password",
      description = "Password of the user",
      example = "test"
  )
  @NotBlank(message = "blank.field.password")
  private String password;
}
