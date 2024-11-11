package com.didan.forum.users.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@Schema(name = "UpdateUserAdminRequestDto", description = "Update User Request Dto")
public class UpdateUserAdminRequestDto {

  @Schema(
      name = "firstName",
      description = "User first name",
      example = "John"
  )
  @Size(max = 255, message = "invalid.field.firstName")
  private String firstName;

  @Schema(
      name = "lastName",
      description = "User last name",
      example = "Doe"
  )
  @Size(max = 255, message = "invalid.field.lastName")
  private String lastName;

  @Schema(
      name = "email",
      description = "User email",
      example = "johndoe@exmaple.com"
  )
  @Size(max = 255, message = "invalid.field.email")
  private String email;

  @Schema(
      name = "birthDay",
      description = "User birth day",
      example = "1990-01-01"
  )
  private LocalDate birthDay;

  @Schema(
      name = "country",
      description = "User country",
      example = "Vietnam"
  )
  @Size(max = 255, message = "invalid.field.country")
  private String country;

  @Schema(
      name = "phoneNumber",
      description = "User phone number",
      example = "0123456789"
  )
  private String phoneNumber;

  @Schema(
      name = "gender",
      description = "Gender",
      example = "Male"
  )
  @Pattern(regexp = "^(Male|Female|)$", message = "invalid.field.gender")
  private String gender;

  @Schema(
      name = "city",
      description = "City",
      example = "123 Main St"
  )
  @Size(max = 255, message = "invalid.field.city")
  private String city;

  @Schema(
      name = "postalCode",
      description = "Postal code",
      example = "12345"
  )
  private Long postalCode;

  @Schema(
      name = "isVerified",
      description = "User is verified or not",
      example = "true"
  )
  @Pattern(regexp = "^(true|TRUE|True|FALSE|False|false|)$", message = "Invalid field isVerified, must be true or false")
  private String isVerified;

  @Schema(
      name = "picture",
      description = "File to be uploaded"
  )
  private MultipartFile picture;
}
