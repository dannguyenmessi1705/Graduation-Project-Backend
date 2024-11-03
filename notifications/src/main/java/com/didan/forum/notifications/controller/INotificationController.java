package com.didan.forum.notifications.controller;

import com.didan.forum.notifications.dto.response.GeneralResponse;
import com.didan.forum.notifications.entity.notification.NotificationEntity;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
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
      }
  )
  @GetMapping("/all")
  ResponseEntity<GeneralResponse<List<NotificationEntity>>> getAllNotifications(
      @RequestParam(name = "page", defaultValue = "0") Integer page
  );
}
