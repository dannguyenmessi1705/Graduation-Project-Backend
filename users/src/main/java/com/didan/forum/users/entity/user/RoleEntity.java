package com.didan.forum.users.entity.user;

import com.didan.forum.users.entity.SuperClass;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import java.io.Serializable;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "role")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class RoleEntity extends SuperClass implements Serializable {

  @Id
  private String id;

  @Column(unique = true)
  private String name;


  @OneToMany(mappedBy = "role", cascade = CascadeType.ALL)
  @JsonManagedReference
  @JsonIgnore
  private List<UserRoleEntity> userRoles;
}
