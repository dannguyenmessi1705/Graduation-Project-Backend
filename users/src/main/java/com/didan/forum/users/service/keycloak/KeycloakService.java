package com.didan.forum.users.service.keycloak;

import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class KeycloakService {
  Keycloak keycloak;

  @Value("${keycloak.management-user.server}")
  private String serverUrl;

  @Value("${keycloak.management-user.realm}")
  private String realm;

  @Value("${keycloak.management-user.client-id}")
  private String clientId;

  @Value("${keycloak.management-user.grant-type}")
  private String grantType;

  @Value("${keycloak.management-user.name}")
  private String username;

  @Value("${keycloak.management-user.password}")
  private String password;

  @Value("${keycloak.management-user.client-secret}")
  private String clientSecret;

  public Keycloak getKeycloakInstance() {
    if (keycloak == null) {
      keycloak = KeycloakBuilder.builder()
          .serverUrl(serverUrl)
          .realm(realm)
          .clientId(clientId)
          .grantType(grantType)
          .username(username)
          .password(password)
          .clientSecret(clientSecret)
          .build();
    }
    return keycloak;
  }
}