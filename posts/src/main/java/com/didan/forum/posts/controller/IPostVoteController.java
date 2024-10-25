package com.didan.forum.posts.controller;

import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.response.PostVoteResponseDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
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

@Tag(
    name = "Post Vote Controller",
    description = "Operations related to post votes"
)
@RequestMapping("${spring.application.name}/votes")
@Validated
public interface IPostVoteController {
  @Operation(
      summary = "Vote a post",
      description = "Vote a post",
      responses = {
          @ApiResponse(
              responseCode = "201",
              description = "Post voted successfully",
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
  @PostMapping("/add/{postId}")
  ResponseEntity<GeneralResponse<Void>> votePost(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId,
      @NotBlank(message = "blank.field.vote.type") @Pattern(regexp = "UP|DOWN|up|down", message = "invalid.vote.type") @RequestParam("type") String type,
      HttpServletRequest request);

  @Operation(
      summary = "Revoke a vote",
      description = "Revoke a vote",
      responses = {
          @ApiResponse(
              responseCode = "201",
              description = "Vote revoked successfully",
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
  @DeleteMapping("/revoke/{postId}")
  ResponseEntity<GeneralResponse<Void>> revokeVote(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId,
      HttpServletRequest request);

  @Operation(
      summary = "Count votes of a post",
      description = "Count votes of a post",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Votes counted successfully",
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
  @GetMapping("/count/{postId}")
  ResponseEntity<GeneralResponse<Long>> countVotes(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId,
      @NotBlank(message = "blank.field.vote.type") @Pattern(regexp = "UP|DOWN|up|down", message =
          "invalid.vote.type") @RequestParam("type") String type,
      HttpServletRequest request);

  @GetMapping("/get/{postId}")
  ResponseEntity<GeneralResponse<List<PostVoteResponseDto>>> getVotesType(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId,
      @NotBlank(message = "blank.field.vote.type") @Pattern(regexp = "UP|DOWN|up|down", message =
          "invalid.vote.type") @RequestParam("type") String type,
      HttpServletRequest request);

}
