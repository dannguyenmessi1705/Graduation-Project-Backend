package com.didan.forum.users.controller;

import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.request.LoginRequestDto;
import com.didan.forum.users.dto.request.LogoutRequestDto;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.dto.response.LoginResponseDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("${spring.application.name}")
@Tag(
    name = "User",
    description = "API routes for CRUD operations on users"
)
@Validated
public interface IUserController {

  @Operation(
      summary = "Login to user account",
      description = "Login to user account with the provided credentials",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "User logged in successfully",
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
  @PostMapping(path = "/login")
  ResponseEntity<GeneralResponse<LoginResponseDto>> loginUser(
      @Valid @RequestBody LoginRequestDto requestDto);

  @Operation(
      summary = "Logout from user account",
      description = "Logout from user account with the provided refresh token",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "User logged out successfully",
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
  @PostMapping(path = "/logout")
  ResponseEntity<GeneralResponse<Void>> logoutUser(
      @Valid @RequestBody LogoutRequestDto requestDto);

  @Operation(
      summary = "Create a new user account",
      description = "Create a new user account with the provided details",
      responses = {
          @ApiResponse(
              responseCode = "201",
              description = "User account created successfully",
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
  @PostMapping(path = "/register", produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
  ResponseEntity<GeneralResponse<UserResponseDto>> createUser(
      @Valid @ModelAttribute CreateUserRequestDto requestDto);
}
