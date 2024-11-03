package com.didan.forum.notifications.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Column;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
@Builder
public class CreateNotificationRequestDto {
  @Schema(
      name = "message",
      description = "Message of the notification",
      example = "You have a new message"
  )
  @NotBlank(message = "blank.field.message")
  @Column(name = "message")
  private String message;
}