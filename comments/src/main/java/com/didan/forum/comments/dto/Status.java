package com.didan.forum.comments.dto;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Status {
  private String apiPath;
  private Integer statusCode;
  private String message;
  private LocalDateTime timestamp;
}