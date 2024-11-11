package com.didan.forum.users.controller;

import com.didan.forum.users.dto.request.AddRoleToUserDto;
import com.didan.forum.users.dto.request.CreateNewRoleDto;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.entity.keycloak.RoleKeycloakEntity;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("${spring.application.name}/keycloak/role")
@Tag(
    name = "Keycloak API",
    description = "API routes for CRUD operations on Keycloak users and roles"
)
@Validated
public interface IKeycloakRoleController {

  @Operation(
      summary = "Get all roles of a user",
      description = "Get all roles of a user from Keycloak",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Roles retrieved successfully",
              content = @Content(
                  schema = @Schema(implementation = GeneralResponse.class)
              )
          ),
          @ApiResponse(
              responseCode = "404",
              description = "User not found",
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
  @GetMapping("/get-roles-user/{userId}")
  ResponseEntity<GeneralResponse<List<RoleKeycloakEntity>>> getAllRolesOfUserFromKeycloak(
      @NotBlank(message = "blank.field.userid")
      @PathVariable("userId") String userId);

  @Operation(
      summary = "Add a role to a user",
      description = "Add a role to a user in Keycloak",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Role added successfully",
              content = @Content(
                  schema = @Schema(implementation = GeneralResponse.class)
              )
          ),
          @ApiResponse(
              responseCode = "404",
              description = "User not found",
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
  @PostMapping("/add-role-user")
  ResponseEntity<GeneralResponse<Void>> addRoleToUserInKeycloak(
      @Valid @RequestBody AddRoleToUserDto requestDto);

  @Operation(
      summary = "Remove a role from a user",
      description = "Remove a role from a user in Keycloak",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Role removed successfully",
              content = @Content(
                  schema = @Schema(implementation = GeneralResponse.class)
              )
          ),
          @ApiResponse(
              responseCode = "404",
              description = "User not found",
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
  @DeleteMapping("/remove-role-user")
  ResponseEntity<GeneralResponse<Void>> removeRoleFromUserInKeycloak(
      @Valid @RequestBody AddRoleToUserDto requestDto);

  @Operation(
      summary = "Get all roles from Keycloak",
      description = "Get all roles from Keycloak",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Roles retrieved successfully",
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
  @GetMapping("/all")
  ResponseEntity<GeneralResponse<List<RoleKeycloakEntity>>> getAllRolesFromKeycloak();

  @Operation(
      summary = "Get a role from Keycloak",
      description = "Get a role from Keycloak",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Role retrieved successfully",
              content = @Content(
                  schema = @Schema(implementation = GeneralResponse.class)
              )
          ),
          @ApiResponse(
              responseCode = "404",
              description = "Role not found",
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
  @GetMapping("/get-role/{roleName}")
  ResponseEntity<GeneralResponse<RoleKeycloakEntity>> getRoleFromKeycloak(
      @NotBlank(message = "blank.field.roleName")
      @PathVariable("roleName") String roleName);

  @Operation(
      summary = "Create a role in Keycloak",
      description = "Create a role in Keycloak",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Role created successfully",
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
  @PostMapping("/create-role")
  ResponseEntity<GeneralResponse<Void>> createRoleInKeycloak(
      @Valid @RequestBody CreateNewRoleDto role);

  @Operation(
      summary = "Delete a role from Keycloak",
      description = "Delete a role from Keycloak",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Role deleted successfully",
              content = @Content(
                  schema = @Schema(implementation = GeneralResponse.class)
              )
          ),
          @ApiResponse(
              responseCode = "404",
              description = "Role not found",
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
  @DeleteMapping("/delete-role/{roleName}")
  ResponseEntity<GeneralResponse<Void>> deleteRoleFromKeycloak(
      @NotBlank(message = "blank.field.roleName")
      @PathVariable("roleName") String roleName);
}
