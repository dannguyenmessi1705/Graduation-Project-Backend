package com.didan.forum.users.dto;

import lombok.Data;

@Data
public class UserDto {
  private String id;
  private String firstName;
  private String lastName;
  private String email;
  private String username;
  private String password;
}
