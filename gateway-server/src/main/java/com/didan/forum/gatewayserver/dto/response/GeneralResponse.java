package com.didan.forum.gatewayserver.dto.response;

import com.didan.forum.gatewayserver.dto.Status;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class GeneralResponse<T> {
  private Status status;
  private T data;
}
