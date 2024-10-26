package com.didan.forum.users.controller;

import com.didan.forum.users.dto.request.ChangePasswordUserDto;
import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.request.LoginRequestDto;
import com.didan.forum.users.dto.request.LogoutRequestDto;
import com.didan.forum.users.dto.request.UpdateUserRequestDto;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.dto.response.LoginResponseDto;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

  @Operation(
      summary = "Update user account",
      description = "Update user account with the provided details",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "User account updated successfully",
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
  @PutMapping(path = "/update", produces = MediaType.APPLICATION_JSON_VALUE, consumes =
      MediaType.MULTIPART_FORM_DATA_VALUE)
  ResponseEntity<GeneralResponse<UserResponseDto>> updateUser(
      @ModelAttribute UpdateUserRequestDto requestDto);

  @Operation(
      summary = "Get user account details",
      description = "Get user account details with the provided user ID",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "User account details retrieved successfully",
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
  @GetMapping(path = "/detail/{userId}", produces = MediaType.APPLICATION_JSON_VALUE)
  ResponseEntity<GeneralResponse<UserResponseDto>> getDetailUser(
      @NotBlank(message = "blank.field.userid") @PathVariable("userId") String userId);

  @Operation(
      summary = "Find users",
      description = "Find users with the provided keyword, page, and size",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Users found successfully",
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
  @GetMapping(path = "/find", produces = MediaType.APPLICATION_JSON_VALUE)
  ResponseEntity<GeneralResponse<List<UserResponseDto>>> findUsers(
      @NotBlank(message = "blank.field.keyword") @RequestParam("keyword") String keyword,
      @RequestParam("page") int page);

  @Operation(
      summary = "Update user password",
      description = "Update user password with the provided details",
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
  @PutMapping(path = "/update/password")
  ResponseEntity<GeneralResponse<Void>> updatePasswordByUser(@Valid @RequestBody ChangePasswordUserDto requestDto);

  @Operation(
      summary = "Request password reset",
      description = "Request password reset with the provided email",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Password reset requested successfully",
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
  @PostMapping(path = "/reset/password/{userId}")
  ResponseEntity<GeneralResponse<Void>> requestResetPassword(
      @NotBlank(message = "blank.field.userid") @PathVariable("userId") String userId);

  @Operation(
      summary = "Get QR code for user account",
      description = "Get QR code for user account with the provided user ID",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "QR code retrieved successfully",
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
  @GetMapping(path = "/qrcode", produces = MediaType.IMAGE_PNG_VALUE)
  ResponseEntity<byte[]> getQRCode();

  @Operation(
      summary = "Check if user exists",
      description = "Check if user exists with the provided user ID"
  )
  @GetMapping("/check/{userId}")
  ResponseEntity<GeneralResponse<Boolean>> checkUserExists(@NotBlank(message = "blank.field.userid") @PathVariable(
      "userId") String userId);
}
