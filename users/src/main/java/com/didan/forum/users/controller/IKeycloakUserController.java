package com.didan.forum.users.controller;

import com.didan.forum.users.dto.request.ChangePasswordAdminDto;
import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.request.UpdateUserAdminRequestDto;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.dto.response.UserResponseDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import java.util.List;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("${spring.application.name}/keycloak/user")
@Tag(
    name = "Keycloak API",
    description = "API routes for CRUD operations on Keycloak users and roles"
)
@Validated
public interface IKeycloakUserController {

  @Operation(
      summary = "Get all users",
      description = "Get all users from Keycloak",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "User account verified successfully",
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
      }
  )
  @GetMapping("/all")
  ResponseEntity<GeneralResponse<List<UserResponseDto>>> getAllUsersFromKeycloak(
  );

  @Operation(
      summary = "Get user details",
      description = "Get user details from Keycloak",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "User details retrieved successfully",
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
      }
  )
  @GetMapping("/{userId}")
  ResponseEntity<GeneralResponse<UserResponseDto>> getUserDetailsFromKeycloak(
      @NotBlank(message = "blank.field.userid") @PathVariable("userId") String userId
      );

  @Operation(
      summary = "Create user",
      description = "Create a user in Keycloak",
      responses = {
          @ApiResponse(
              responseCode = "201",
              description = "User created successfully",
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
      }
  )
  @PostMapping(path = "/create", produces = MediaType.APPLICATION_JSON_VALUE, consumes =
      MediaType.MULTIPART_FORM_DATA_VALUE)
  ResponseEntity<GeneralResponse<UserResponseDto>> createUserInKeycloak(
      @Valid @ModelAttribute CreateUserRequestDto user);

  @Operation(
      summary = "Update user",
      description = "Update a user in Keycloak",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "User updated successfully",
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
      }
  )
  @PutMapping(path = "/{userId}", produces = MediaType.APPLICATION_JSON_VALUE, consumes =
      MediaType.MULTIPART_FORM_DATA_VALUE)
  ResponseEntity<GeneralResponse<UserResponseDto>> updateUserInKeycloak(
      @Valid @ModelAttribute UpdateUserAdminRequestDto requestDto,
      @NotBlank(message = "blank.field.userid") @PathVariable("userId") String userId);

  @Operation(
      summary = "Update user password",
      description = "Update a user's password in Keycloak",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "User password updated successfully",
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
      }
  )
  @PutMapping(path = "/{userId}/password", produces = MediaType.APPLICATION_JSON_VALUE)
  ResponseEntity<GeneralResponse<UserResponseDto>> updateUserPasswordInKeycloak(
      @NotBlank(message = "blank.field.userid") @PathVariable("userId") String userId,
      @Valid @RequestBody ChangePasswordAdminDto requestDto);

  @Operation(
      summary = "Delete user",
      description = "Delete a user from Keycloak",
      responses = {
          @ApiResponse(
              responseCode = "204",
              description = "User deleted successfully",
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
      }
  )
  @DeleteMapping("/{userId}/delete")
  ResponseEntity<GeneralResponse<Void>> deleteUserFromKeycloak(
      @NotBlank(message = "blank.field.userid") @PathVariable("userId") String userId);

}
