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
      name = "title",
      description = "Title of the notification",
      example = "You have a new message from admin"
  )
  @NotBlank(message = "blank.field.title")
  @Column(name = "title")
  private String title;

  @Schema(
      name = "content",
      description = "Content of the notification",
      example = "The forum is off in 0 AM to update"
  )
  @NotBlank(message = "blank.field.content")
  @Column(name = "content")
  private String content;
}