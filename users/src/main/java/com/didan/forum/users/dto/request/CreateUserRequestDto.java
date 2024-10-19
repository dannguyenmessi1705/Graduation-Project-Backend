package com.didan.forum.users.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.Length;
import org.springframework.web.multipart.MultipartFile;

@Schema(name = "CreateUserRequestDto", description = "Create User Request Dto")
@AllArgsConstructor @NoArgsConstructor @Data
public class CreateUserRequestDto {
  @Schema(
      name = "firstName",
      description = "User first name",
      example = "John"
  )
  @NotBlank(message = "blank.field.firstName")
  @Size(max = 255, message = "invalid.field.firstName")
  @Pattern(regexp = "^[a-zA-Z]*$", message = "invalid.field.firstName")
  private String firstName;

  @Schema(
      name = "lastName",
      description = "User last name",
      example = "Doe"
  )
  @NotBlank(message = "blank.field.lastName")
  @Size(max = 255, message = "invalid.field.lastName")
  @Pattern(regexp = "^[a-zA-Z]*$", message = "invalid.field.lastName")
  private String lastName;

  @Schema(
      name = "email",
      description = "User email",
      example = "johndoe@exmaple.com"
  )
  @NotBlank(message = "blank.field.email")
  @Size(max = 255, message = "invalid.field.email")
  @Email(message = "invalid.field.email")
  private String email;

  @Schema(
      name = "username",
      description = "User username",
      example = "johndoe"
  )
  @NotBlank(message = "blank.field.username")
  @Size(max = 255, message = "invalid.field.username")
  @Pattern(regexp = "^[a-zA-Z0-9]*$", message = "invalid.field.username")
  private String username;

  @Schema(
      name = "password",
      description = "User password",
      example = "password"
  )
  @NotBlank(message = "blank.field.password")
  @Size(min = 8, message = "invalid.field.password")
  private String password;

  @Schema(
      name = "birthDay",
      description = "User birth day",
      example = "1990-01-01"
  )
  @Pattern(regexp = "^[0-9]{4}-[0-9]{2}-[0-9]{2}$", message = "invalid.field.birthDay")
  private LocalDate birthDay;

  @Schema(
      name = "country",
      description = "User country",
      example = "Vietnam"
  )
  @Size(max = 255, message = "invalid.field.country")
  @Pattern(regexp = "^[a-zA-Z]*$", message = "invalid.field.country")
  private String country;

  @Schema(
      name = "phoneNumber",
      description = "User phone number",
      example = "0123456789"
  )
  @NotBlank(message = "blank.field.phoneNumber")
  @Size(min = 9, max = 11, message = "invalid.field.phoneNumber")
  @Pattern(regexp = "^[0-9]*$", message = "invalid.field.phoneNumber")
  private String phoneNumber;

  @Schema(
      name = "gender",
      description = "Gender",
      example = "Male"
  )
  @Pattern(regexp = "^(Male|Female|)$", message="invalid.field.gender")
  private String gender;

  @Schema(
      name = "city",
      description = "City",
      example = "123 Main St"
  )
  @Size(max = 255, message = "invalid.field.city")
  @Pattern(regexp = "^[a-zA-Z]*$", message = "invalid.field.city")
  private String city;

  @Schema(
      name = "postalCode",
      description = "Postal code",
      example = "12345"
  )
  @Max(value = 99999999, message = "invalid.field.postalCode")
  @Min(value = 0, message = "invalid.field.postalCode")
  @Pattern(regexp = "^[0-9]*$", message = "invalid.field.postalCode")
  private Long postalCode;

  @Schema(
      name = "picture",
      description = "File to be uploaded"
  )
  private MultipartFile picture;
}
