package com.didan.forum.notifications.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@Schema(
    name = "CreateRoomRequestDto",
    description = "The request dto for creating a room"
)
public class CreateRoomRequestDto {
  @Schema(
      name = "user_creator_id",
      description = "The id of the user creator",
      example = "12515"
  )
  @NotBlank(message = "blank.field.userid")
  private String userCreatorId;

  @Schema(
      name = "user_joiner_id",
      description = "The id of the user joiner",
      example = "12516"
  )
  @NotBlank(message = "blank.field.userid")
  private String userJoinerId;
}
