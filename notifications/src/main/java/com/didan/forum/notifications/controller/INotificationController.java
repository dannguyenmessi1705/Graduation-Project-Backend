package com.didan.forum.notifications.controller;

import com.didan.forum.notifications.dto.request.CreateNotificationRequestDto;
import com.didan.forum.notifications.dto.response.GeneralResponse;
import com.didan.forum.notifications.entity.notification.NotificationEntity;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
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

@Tag(
    name = "Notification",
    description = "Notification API"
)
@RequestMapping("${spring.application.name}")
@Validated
public interface INotificationController {

  @Operation(
      summary = "Get all notifications",
      description = "Get all notifications of a user",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "List of notifications",
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
  @GetMapping("/all")
  ResponseEntity<GeneralResponse<List<NotificationEntity>>> getAllNotifications(
      @RequestParam(name = "page", defaultValue = "0") Integer page
  );

  @Operation(
      summary = "Get unread notifications",
      description = "Get unread notifications of a user",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "List of unread notifications",
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
  @GetMapping("/unread")
  ResponseEntity<GeneralResponse<List<NotificationEntity>>> getUnreadNotifications(
      @RequestParam(name = "page", defaultValue = "0") Integer page
  );

  @Operation(
      summary = "Get unread notifications count",
      description = "Get unread notifications count of a user",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Unread notifications count",
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
  @GetMapping("/unread/count")
  ResponseEntity<GeneralResponse<Long>> getUnreadNotificationsCount();

  @Operation(
      summary = "Mark as read",
      description = "Mark a notification as read",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Notification marked as read",
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
  @PutMapping("/mark/read/{notificationId}")
  ResponseEntity<GeneralResponse<Void>> markAsRead(
      @NotBlank(message = "blank.field.notification.id") @PathVariable(name = "notificationId") Long notificationId
  );

  @Operation(
      summary = "Mark all as read",
      description = "Mark all notifications as read",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "All notifications marked as read",
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
  @PutMapping("/mark/read/all")
  ResponseEntity<GeneralResponse<Void>> markAllAsRead();

  @Operation(
      summary = "Delete notification",
      description = "Delete a notification",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "Notification deleted",
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
  @DeleteMapping("/delete/{notificationId}")
  ResponseEntity<GeneralResponse<Void>> deleteNotification(
      @NotBlank(message = "blank.field.notification.id") @PathVariable(name = "notificationId") Long notificationId
  );

  @Operation(
      summary = "Delete all notifications",
      description = "Delete all notifications",
      responses = {
          @ApiResponse(
              responseCode = "200",
              description = "All notifications deleted",
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
  @DeleteMapping("/delete/all")
  ResponseEntity<GeneralResponse<Void>> deleteAllNotifications();

  @Operation(
      summary = "Create notification by admin",
      description = "Create a notification by admin",
      responses = {
          @ApiResponse(
              responseCode = "201",
              description = "Notification created",
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
  @PostMapping("/admin/create")
  ResponseEntity<GeneralResponse<Void>> createNotificationByAdmin(
      @Valid @RequestBody CreateNotificationRequestDto requestDto
  );

}
