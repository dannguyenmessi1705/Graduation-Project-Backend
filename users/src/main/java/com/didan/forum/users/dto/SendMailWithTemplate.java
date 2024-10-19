package com.didan.forum.users.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor @NoArgsConstructor @Data
public class SendMailWithTemplate {
  private String firstName;
  private String lastName;
  private String email;
  private String phoneNumber;
  private String message;
}
