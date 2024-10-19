package com.didan.forum.users.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;
import java.io.Serializable;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Generated;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "password_request")
@NoArgsConstructor @AllArgsConstructor @Setter @Getter @ToString
public class PasswordRequestEntity extends SuperClass implements Serializable {
  @Id
  private String id;

  @Column
  private String token;

  @Column
  private LocalDateTime expiredAt;

  @OneToOne
  @MapsId
  @JoinColumn(name = "id")
  private UserEntity user;

  @PrePersist
  public void init() {
    this.expiredAt = LocalDateTime.now().plusMinutes(10);
  }
}
