package com.didan.forum.users.entity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.Lob;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "user")
@Table(indexes = {
    @Index(name = "idx_user_email", columnList = "email"),
    @Index(name = "idx_user_username", columnList = "username"),
    @Index(name = "idx_phone_number", columnList = "phoneNumber")
})
@AllArgsConstructor
@NoArgsConstructor
@Setter @Getter @ToString
public class UserEntity extends SuperClass implements Serializable {
  @Id
  @GeneratedValue(strategy = GenerationType.UUID)
  private String id;

  @Column
  private String firstName;

  @Column
  private String lastName;

  @Column(unique = true)
  private String email;

  @Column(unique = true, updatable = false)
  private String username;

  @Column
  private String password;

  @Column
  private LocalDate birthDay;

  @Column
  private String country;

  @Column(unique = true)
  private String phoneNumber;

  @Column
  private String gender;

  @Column
  private String city;

  @Column
  private Long postalCode;

  @Lob
  @Column(length = 16777216)
  private String picture;

  @OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
  private List<UserRoleEntity> userRoles;

  @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
  @PrimaryKeyJoinColumn
  private PasswordRequestEntity passwordRequest;
}
