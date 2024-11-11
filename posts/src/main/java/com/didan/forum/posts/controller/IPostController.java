package com.didan.forum.posts.controller;

import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.request.CreatePostRequestDto;
import com.didan.forum.posts.dto.request.ReportPostDto;
import com.didan.forum.posts.dto.request.UpdatePostRequestDto;
import com.didan.forum.posts.dto.response.PostResponseDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import java.util.List;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
      },
      security = @SecurityRequirement(name = "Keycloak")
  )
  @PostMapping(path = "/new", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
  ResponseEntity<GeneralResponse<PostResponseDto>> createPost(
      @Valid @ModelAttribute CreatePostRequestDto requestDto);

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
      },
      security = @SecurityRequirement(name = "Keycloak")
  )
  @PutMapping(path = "/update/{postId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces =
      MediaType.APPLICATION_JSON_VALUE)
  ResponseEntity<GeneralResponse<PostResponseDto>> updatePost(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId,
      @Valid @ModelAttribute UpdatePostRequestDto requestDto
  );

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
  ResponseEntity<GeneralResponse<List<PostResponseDto>>> getPosts(
      @RequestParam(name = "searchType", defaultValue = "new") String searchType,
      @RequestParam(name = "page", defaultValue = "0") int page
  );

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
  ResponseEntity<GeneralResponse<PostResponseDto>> getPost(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId
  );

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
  ResponseEntity<GeneralResponse<List<PostResponseDto>>> searchPosts(
      @NotBlank(message = "blank.field.key") @RequestParam("key") String key,
      @RequestParam(name = "searchType", defaultValue = "content") String searchType,
      @RequestParam(name = "page", defaultValue = "0") int page
  );

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
  ResponseEntity<GeneralResponse<List<PostResponseDto>>> getPostsByTopic(
      @NotBlank(message = "blank.field.topicId") @PathVariable("topicId") String topicId,
      @RequestParam(name = "type", defaultValue = "new") String type,
      @RequestParam(name = "page", defaultValue = "0") int page
  );

  @Operation(
      summary = "Get posts by user",
      description = "Get posts by user",
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
  @GetMapping("/author/{userId}")
  ResponseEntity<GeneralResponse<List<PostResponseDto>>> getPostsByUser(
      @NotBlank(message = "blank.field.userId") @PathVariable("userId") String userId,
      @RequestParam(name = "page", defaultValue = "0") int page
  );

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
      },
      security = @SecurityRequirement(name = "Keycloak")
  )
  @DeleteMapping("/delete/{postId}")
  ResponseEntity<GeneralResponse<Void>> deletePost(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId
  );

  @Operation(
      summary = "Delete a post by admin",
      description = "Delete a post by admin",
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
      },
      security = @SecurityRequirement(name = "Keycloak")
  )
  @DeleteMapping("/admin/delete/{postId}")
  ResponseEntity<GeneralResponse<Void>> deletePostByAdmin(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId
  );

  @Operation(
      summary = "Report a post",
      description = "Report a post",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Post reported successfully",
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
  @PostMapping("/report/{postId}")
  ResponseEntity<GeneralResponse<Void>> reportPost(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId,
      @Valid @RequestBody ReportPostDto reportPostDto
  );

  @Operation(
      summary = "Check if post exists",
      description = "Check if post exists",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Post exists",
              content = @Content(
                  schema = @Schema(implementation = GeneralResponse.class)
              )
          ),
          @ApiResponse(
              responseCode = "404",
              description = "Post does not exist",
              content = @Content(
                  schema = @Schema(implementation = GeneralResponse.class)
              )
          )
      }
  )
  @GetMapping("/exists/{postId}")
  ResponseEntity<GeneralResponse<Boolean>> checkPostExist(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId
  );
}
