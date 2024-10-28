package com.didan.forum.gatewayserver.security;

import java.util.Set;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.config.annotation.web.reactive.EnableWebFluxSecurity;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.config.web.server.ServerHttpSecurity.CorsSpec;
import org.springframework.security.config.web.server.ServerHttpSecurity.CsrfSpec;
import org.springframework.security.config.web.server.ServerHttpSecurity.FormLoginSpec;
import org.springframework.security.config.web.server.ServerHttpSecurity.HttpBasicSpec;
import org.springframework.security.config.web.server.ServerHttpSecurity.LogoutSpec;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.oauth2.server.resource.authentication.ReactiveJwtAuthenticationConverterAdapter;
import org.springframework.security.web.server.SecurityWebFilterChain;
import org.springframework.security.web.server.context.NoOpServerSecurityContextRepository;
import org.springframework.security.web.server.savedrequest.NoOpServerRequestCache;
import org.springframework.web.server.session.WebSessionManager;
import reactor.core.publisher.Mono;

@Configuration
@EnableWebFluxSecurity
public class GatewaySecurityConfig {

  @Bean
  public SecurityWebFilterChain securityWebFilterChain(ServerHttpSecurity http) throws Exception {
    return http.authorizeExchange(exchanges ->
            exchanges
                .pathMatchers("/forum/api-docs/**", "/forum/swagger-ui/**", "/forum/users/api-docs/**")
                .permitAll()
                .pathMatchers("/forum/users/update/**", "/forum/users/qrcode/**", "/forum/users"
                    + "/role/**", "/forum/users/report/**", "/forum/posts/report/**", "/forum"
                    + "/posts/votes/add/**", "/forum/posts/votes/revoke/**", "/forum/posts/delete"
                    + "/**", "/forum/posts/new/**", "/forum/posts/update/**", "/forum/posts"
                    + "/report/**")
                .hasAnyRole("user", "admin")
                .pathMatchers("/forum/users/keycloak/**", "/forum/posts/topic/update/**",
                    "/forum/posts/topic/delete/**", "/forum/posts/topic/create/**", "/forum/topic"
                        + "/create/**", "/forum/topic/update/**", "/forum/topic/delete/**",
                    "/forum/posts/admin/delete/**")
                .hasRole("admin")
                .anyExchange()
                .permitAll())
        .oauth2ResourceServer(oauth2 -> oauth2.jwt(
            grantedRole -> grantedRole.jwtAuthenticationConverter(grantedAuthoritiesExtractor()))
        )
        .csrf(CsrfSpec::disable)
        .cors(CorsSpec::disable)
        .formLogin(FormLoginSpec::disable)
        .httpBasic(HttpBasicSpec::disable)
        .logout(LogoutSpec::disable)
        .requestCache(
            requestCacheSpec -> requestCacheSpec.requestCache(NoOpServerRequestCache.getInstance())) // Disable RequestCache = SessionCreationPolicy.STATELESS
        .securityContextRepository(NoOpServerSecurityContextRepository.getInstance()) // Disable SecurityContextRepository = SessionCreationPolicy.STATELESS
        .build();
  }

  @Bean
  public WebSessionManager webSessionManager() {
    return exchange -> Mono.empty();
  } // Disable WebSessionManager = SessionCreationPolicy.STATELESS

  private Converter<Jwt, Mono<AbstractAuthenticationToken>> grantedAuthoritiesExtractor() {
    JwtAuthenticationConverter jwtAuthenticationConverter = new JwtAuthenticationConverter();
    jwtAuthenticationConverter.setJwtGrantedAuthoritiesConverter(new KeycloakRoleConverter());
    return new ReactiveJwtAuthenticationConverterAdapter(jwtAuthenticationConverter);
  }
}