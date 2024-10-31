package com.didan.forum.comments.controller;

import com.didan.forum.comments.dto.response.GeneralResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.NotBlank;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("${spring.application.name}")
@Validated
@Tag(
    name = "Comment",
    description = "API routes for CRUD operations on comments"
)
public interface ICommentController {

  @Operation(
      summary = "Count the number comments in a post",
      description = "Count the number of comments in a post",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Post updated successfully",
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
  ResponseEntity<GeneralResponse<Long>> countComments(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId);
}
