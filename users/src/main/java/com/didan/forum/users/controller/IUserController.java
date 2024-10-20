package com.didan.forum.users.controller;

import com.didan.forum.users.dto.request.CreateUserRequestDto;
import com.didan.forum.users.dto.response.GeneralResponse;
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
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("${spring.application.name}")
@Tag(
    name = "User",
    description = "API routes for CRUD operations on users"
)
@Validated
public interface IUserController {

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
