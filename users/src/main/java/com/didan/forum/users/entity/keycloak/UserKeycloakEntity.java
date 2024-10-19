package com.didan.forum.users.entity.keycloak;

import lombok.Data;

@Data
public class UserKeycloakEntity {
    private String id;
    private String firstName;
    private String lastName;
    private String email;
    private String username;
    private String password;
}
