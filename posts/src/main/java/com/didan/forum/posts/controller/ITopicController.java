package com.didan.forum.posts.controller;

import com.didan.forum.posts.dto.request.CreateTopicRequestDto;
import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.response.TopicResponseDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("${spring.application.name}/topic")
@Validated
@Tag(
    name = "Topic",
    description = "Operations related to topics"
)
public interface ITopicController {
  @Operation(
      summary = "Create a new topic by admin",
      description = "Create a new topic by admin",
      responses = {
          @ApiResponse(
              responseCode = "201",
              description = "Topic created successfully",
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
  @PostMapping("/create")
  ResponseEntity<GeneralResponse<TopicResponseDto>> createTopic(@Valid @RequestBody
      CreateTopicRequestDto requestDto);

  @Operation(
      summary = "Get all topics",
      description = "Get all topics",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Topics retrieved successfully",
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
  @GetMapping("/all")
  ResponseEntity<GeneralResponse<List<TopicResponseDto>>> getAllTopics(
      @RequestParam(value = "page", defaultValue = "0") int page
  );

  @Operation(
      summary = "Get a topic by name",
      description = "Get a topic by name",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Topic retrieved successfully",
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
  @GetMapping("/get")
  ResponseEntity<GeneralResponse<List<TopicResponseDto>>> getTopicsByName(@NotBlank(message = "blank.field.topic.name")
      @RequestParam("name") String name,
      @RequestParam(value = "page", defaultValue = "0") int page);

  @Operation(
      summary = "Get details of a topic",
      description = "Get details of a topic",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Topic details retrieved successfully",
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
  @GetMapping("/details/{topicId}")
  ResponseEntity<GeneralResponse<TopicResponseDto>> getTopicDetails(@NotBlank(message = "blank.field.topic.id")
      @PathVariable("topicId") String topicId);

  @Operation(
      summary = "Update a topic by admin",
      description = "Update a topic by admin",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Topic updated successfully",
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
  @PutMapping("/update/{topicId}")
  ResponseEntity<GeneralResponse<TopicResponseDto>> updateTopic(@NotBlank(message = "blank.field.topic.id")
      @PathVariable("topicId") String topicId,
      @Valid @RequestBody CreateTopicRequestDto requestDto);

  @Operation(
      summary = "Delete a topic by admin",
      description = "Delete a topic by admin",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Topic deleted successfully",
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
  @DeleteMapping("/delete/{topicId}")
  ResponseEntity<GeneralResponse<Void>> deleteTopic(
      @NotBlank(message = "blank.field.topic.id")
      @PathVariable("topicId") String topicId);

}
