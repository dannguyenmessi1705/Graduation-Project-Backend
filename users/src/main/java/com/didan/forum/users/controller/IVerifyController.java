package com.didan.forum.users.controller;

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
}
