package com.didan.forum.comments.controller;

import com.didan.forum.comments.dto.request.CreateCommentRequestDto;
import com.didan.forum.comments.dto.request.ReportCommentDto;
import com.didan.forum.comments.dto.response.CommentResponseDto;
import com.didan.forum.comments.dto.response.GeneralResponse;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("${spring.application.name}")
@Validated
@Tag(
    name = "Comment",
    description = "API routes for CRUD operations on comments"
)
public interface ICommentController {
  @Operation(
      summary = "Create a comment",
      description = "Create a comment",
      responses = {
          @ApiResponse(
              responseCode = "201",
              description = "Comment created successfully",
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
  @PostMapping(value = "/create", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
  ResponseEntity<GeneralResponse<CommentResponseDto>> createComment(
      @Valid @RequestBody CreateCommentRequestDto requestDto);

  @Operation(
      summary = "Get comments by post",
      description = "Get comments by post",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Comments retrieved successfully",
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
  @GetMapping("/post/{postId}")
  ResponseEntity<GeneralResponse<List<CommentResponseDto>>> getCommentsByPost(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId,
      @RequestParam(name = "type", defaultValue = "") String type,
      @RequestParam(name = "page", defaultValue = "0") int page);

  @Operation(
      summary = "Delete a comment",
      description = "Delete a comment",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Comment deleted successfully",
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
  @DeleteMapping("/delete/{commentId}")
  ResponseEntity<GeneralResponse<Void>> deleteComment(
      @NotBlank(message = "blank.field.commentId") @PathVariable("commentId") String commentId);

  @Operation(
      summary = "Delete a comment by admin",
      description = "Delete a comment by admin",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Comment deleted successfully",
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
  @DeleteMapping("/admin/delete/{commentId}")
  ResponseEntity<GeneralResponse<Void>> deleteCommentByAdmin(
      @NotBlank(message = "blank.field.commentId") @PathVariable("commentId") String commentId);

  @Operation(
      summary = "Get a comment",
      description = "Get a comment",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Comment retrieved successfully",
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
  ResponseEntity<GeneralResponse<CommentResponseDto>> getComment(
      @NotBlank(message = "blank.field.commentId") @PathVariable("commentId") String commentId);

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

  @PostMapping("/report/{commentId}")
  ResponseEntity<GeneralResponse<Void>> reportComment(
      @NotBlank(message = "blank.field.commentId") @PathVariable("commentId") String commentId,
      @Valid @RequestBody ReportCommentDto requestDto);
}
