package com.didan.forum.users.controller;

import com.didan.forum.users.dto.request.ChangePasswordAdminDto;
import com.didan.forum.users.dto.response.GeneralResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.NotBlank;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("${spring.application.name}/verify")
@Tag(
    name = "Verify",
    description = "API routes for verifying user accounts."
)
public interface IVerifyController {
  @Operation(
      summary = "Verify user account activation",
      description = "Verify user account activation using the token sent to the user's email.",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "User account verified successfully",
              content = @Content(
                  schema = @Schema(implementation = GeneralResponse.class)
              )
          ),
          @ApiResponse(
              responseCode = "400",
              description = "Invalid token",
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
  @GetMapping("/activate")
  ResponseEntity<GeneralResponse<Void>> activateAccount(@NotBlank(message = "blank.field.token") @RequestParam("token") String token);

  @Operation(
      summary = "Reset user account password",
      description = "Reset user account password using the token sent to the user's email.",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "User account password reset successfully",
              content = @Content(
                  schema = @Schema(implementation = GeneralResponse.class)
              )
          ),
          @ApiResponse(
              responseCode = "400",
              description = "Invalid token",
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
  @GetMapping("/reset")
  ResponseEntity<GeneralResponse<ChangePasswordAdminDto>> resetPassword(
      @NotBlank(message = "blank.field.token") @RequestParam("token") String token);

  @Operation(
      summary = "Resend user account activation email",
      description = "Resend user account activation email to the user's email.",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "User account activation email resent successfully",
              content = @Content(
                  schema = @Schema(implementation = GeneralResponse.class)
              )
          ),
          @ApiResponse(
              responseCode = "400",
              description = "User account already verified",
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
  @PostMapping("/reactivate")
  ResponseEntity<GeneralResponse<Void>> resendActivationEmail();
}
