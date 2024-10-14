package com.didan.forum.posts.dto.response;

import com.didan.forum.posts.dto.Status;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Schema(
    name = "GeneralResponse",
    description = "The general response body"
)
public class GeneralResponse<T> {

  @Schema(
      name = "Status",
      description = "The status code of the response"
  )
  private Status status;
  @Schema(
      name = "data",
      description = "The data of the response"
  )
  private T data;
}
