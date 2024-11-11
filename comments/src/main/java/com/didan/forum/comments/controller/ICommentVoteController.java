package com.didan.forum.comments.controller;

import com.didan.forum.comments.dto.response.CommentVoteResponseDto;
import com.didan.forum.comments.dto.response.GeneralResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Validated
@RequestMapping("${spring.application.name}/votes")
@Tag(
    name = "Comment Vote",
    description = "API routes for voting on comments"
)
public interface ICommentVoteController {
  @Operation(
      summary = "Vote on a comment",
      description = "Vote on a comment",
      responses = {
          @ApiResponse(
              responseCode = "201",
              description = "Comment vote created successfully",
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
  @PostMapping("/add/{commentId}")
  ResponseEntity<GeneralResponse<Void>> addVote(
      @NotBlank(message = "blank.field.commentId") @PathVariable("commentId") String commentId,
      @NotBlank(message = "blank.field.vote.type") @Pattern(regexp = "UP|DOWN|up|down", message =
          "invalid.vote.type") @RequestParam("type") String type);

  @Operation(
      summary = "Revoke a vote on a comment",
      description = "Revoke a vote on a comment",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Comment vote revoked successfully",
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
  @DeleteMapping("/revoke/{commentId}")
  ResponseEntity<GeneralResponse<Void>> revokeVote(
      @NotBlank(message = "blank.field.commentId") @PathVariable("commentId") String commentId);

  @Operation(
      summary = "Get vote quantity on a comment",
      description = "Get vote quantity on a comment",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Vote quantity retrieved successfully",
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
  @GetMapping("/count/{commentId}")
  ResponseEntity<GeneralResponse<Long>> getVoteQuantity(
      @NotBlank(message = "blank.field.commentId") @PathVariable("commentId") String commentId,
      @NotBlank(message = "blank.field.vote.type") @Pattern(regexp = "UP|DOWN|up|down", message =
          "invalid.vote.type") @RequestParam("type") String type);

  @Operation(
      summary = "Get votes information on a comment",
      description = "Get votes information on a comment",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Votes information retrieved successfully",
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
  @GetMapping("/get/{commentId}")
  ResponseEntity<GeneralResponse<List<CommentVoteResponseDto>>> getVotes(
      @NotBlank(message = "blank.field.commentId") @PathVariable("commentId") String commentId,
      @NotBlank(message = "blank.field.vote.type") @Pattern(regexp = "UP|DOWN|up|down", message =
          "invalid.vote.type") @RequestParam("type") String type);

}
