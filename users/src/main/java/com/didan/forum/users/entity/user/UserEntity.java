package com.didan.forum.users.entity.user;

import com.didan.forum.users.entity.SuperClass;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.Lob;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "user")
@Table(indexes = {
    @Index(name = "idx_user_email", columnList = "email"),
    @Index(name = "idx_user_username", columnList = "username"),
    @Index(name = "idx_phone_number", columnList = "phone_number"),
})
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class UserEntity extends SuperClass implements Serializable {

  @Id
  private String id;

  @Column(name = "first_name")
  private String firstName;

  @Column(name = "last_name")
  private String lastName;

  @Column(name = "email", unique = true)
  private String email;

  @Column(name = "username", unique = true, updatable = false)
  private String username;

  @Column(name = "password")
  private String password;

  @Column(name = "birth_day")
  private LocalDate birthDay;

  @Column(name = "country")
  private String country;

  @Column(name = "phone_number", unique = true)
  private String phoneNumber;

  @Column(name = "gender")
  private String gender;

  @Column(name = "city")
  private String city;

  @Column(name = "postal_code")
  private Long postalCode;

  @Lob
  @Column(name = "picture", length = 16777216)
  private String picture;

  @Column(columnDefinition = "TINYINT(1)", name = "is_verified")
  private boolean isVerified = false;

  @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
  @JsonManagedReference
  @JsonIgnore
  private List<UserRoleEntity> userRoles;
}
