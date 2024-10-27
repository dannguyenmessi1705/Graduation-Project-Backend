package com.didan.forum.posts.controller;

import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.request.CreatePostRequestDto;
import com.didan.forum.posts.dto.response.PostResponseDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("${spring.application.name}")
@Validated
@Tag(
    name = "Post",
    description = "API routes for CRUD operations on posts"
)
public interface IPostController {
  @Operation(
      summary = "Create a post",
      description = "Create a post",
      responses = {
          @ApiResponse(
              responseCode = "201",
              description = "Post created successfully",
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
  @PostMapping(path = "/new", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
  ResponseEntity<GeneralResponse<PostResponseDto>> createPost(@Valid @ModelAttribute CreatePostRequestDto requestDto);

  @Operation(
      summary = "Update a post",
      description = "Update a post",
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
  @PutMapping(path = "/update", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces =
      MediaType.APPLICATION_JSON_VALUE)
  ResponseEntity<GeneralResponse<Void>> updatePost();

  @Operation(
      summary = "Get list of posts",
      description = "Get list of posts",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Posts retrieved successfully",
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
  @GetMapping("/")
  ResponseEntity<GeneralResponse<Void>> getPosts();

  @Operation(
      summary = "Get a post",
      description = "Get a post",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Post retrieved successfully",
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
  @GetMapping("/{postId}")
  ResponseEntity<GeneralResponse<Void>> getPost();

  @Operation(
      summary = "Search for posts",
      description = "Search for posts",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Posts retrieved successfully",
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
  @GetMapping("/search")
  ResponseEntity<GeneralResponse<Void>> searchPosts();

  @Operation(
      summary = "Get posts by topic",
      description = "Get posts by topic",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Posts retrieved successfully",
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
  @GetMapping("/topic/{topicId}")
  ResponseEntity<GeneralResponse<Void>> getPostsByTopic();

  @Operation(
      summary = "Delete a post",
      description = "Delete a post",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Post deleted successfully",
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
  @DeleteMapping("/{postId}")
  ResponseEntity<GeneralResponse<Void>> deletePost();
}
