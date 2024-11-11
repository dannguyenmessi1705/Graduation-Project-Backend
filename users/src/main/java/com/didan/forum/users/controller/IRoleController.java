package com.didan.forum.users.controller;

import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.entity.user.RoleEntity;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.NotBlank;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("${spring.application.name}/role")
@Tag(
    name = "User",
    description = "API routes for CRUD operations on users"
)
@Validated
public interface IRoleController {

  @Operation(
      summary = "Get roles of user",
      description = "Get roles of user",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Retrieved roles of user",
              content = @Content(
                  schema = @Schema(implementation = GeneralResponse.class)
              )
          ),
          @ApiResponse(
              responseCode = "500",
              description = "Internal server error",
              content = @Content(
                  schema = @Schema(implementation = GeneralResponse.class)
              )
          )
      },
      security = @SecurityRequirement(name = "Keycloak")
  )
  @GetMapping("/get-roles/{userId}")
  ResponseEntity<GeneralResponse<List<RoleEntity>>> getRoles(
      @NotBlank(message = "invalid.field.userId") @PathVariable("userId") String userId);
}
