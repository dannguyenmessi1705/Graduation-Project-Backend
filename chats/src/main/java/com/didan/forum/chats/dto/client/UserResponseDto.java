package com.didan.forum.chats.dto.client;

import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserResponseDto {
  private String id;
  private String firstName;
  private String lastName;
  private String email;
  private String username;
  private LocalDate birthDay;
  private String country;
  private String phoneNumber;
  private String gender;
  private String city;
  private Long postalCode;
  private String picture;
  private boolean isVerified;
}

