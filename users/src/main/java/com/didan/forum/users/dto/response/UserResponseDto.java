package com.didan.forum.users.dto.response;

import com.didan.forum.users.entity.PasswordRequestEntity;
import com.didan.forum.users.entity.UserRoleEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrimaryKeyJoinColumn;
import java.time.LocalDate;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.checkerframework.checker.units.qual.C;

@Schema(name = "UserResponseDto", description = "User response data transfer object")
@AllArgsConstructor @NoArgsConstructor @Data
public class UserResponseDto {
  @Schema(
    name = "id",
    description = "User id",
    example = "123456"
  )
  private String id;

  @Schema(
    name = "firstName",
    description = "User first name",
    example = "John"
  )
  private String firstName;

  @Schema(
    name = "lastName",
    description = "User last name",
    example = "Doe"
  )
  private String lastName;

  @Schema(
    name = "email",
    description = "User email",
    example = "johndoe@exmaple.com"
  )
  private String email;

  @Schema(
    name = "username",
    description = "User username",
    example = "johndoe"
  )
  private String username;

  @Schema(
    name = "password",
    description = "User password",
    example = "password"
  )
  private String password;

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
  private String gender;

  @Schema(
    name = "city",
    description = "City",
    example = "123 Main St"
  )
  private String city;

  @Schema(
    name = "postalCode",
    description = "Postal code",
    example = "12345"
  )
  private Long postalCode;

  @Schema(
    name = "picture",
    description = "User picture URL",
    example = "https://example.com/picture.jpg"
  )
  private String picture;
}
