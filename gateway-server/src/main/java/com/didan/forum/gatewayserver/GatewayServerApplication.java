package com.didan.forum.gatewayserver;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeIn;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import io.swagger.v3.oas.annotations.servers.Server;
import java.time.LocalDateTime;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@OpenAPIDefinition(
    info = @Info(
        title = "Microservice for Gateway service of Z'forum",
        description = "This microservice is responsible for Gateway service of Z'forum",
        version = "${info.app.version}",
        contact = @Contact(
            name = "Nguyễn Di Đan",
            url = "https://iam.didan.id.vn",
            email = "didannguyen17@gmail.com"
        ),
        license = @License(
            name = "Apache 2.0",
            url = "https://www.apache.org/licenses/LICENSE-2.0.html"
        ),
        summary = "Microservice for Gateway service of Z'forum"
    ),
    servers = {
        @Server(
            description = "Local server",
            url = "http://localhost:8072"
        )
    },
    security = {
        @SecurityRequirement(name = "Keycloak")
    }
)
@SecurityScheme(
    name = "Keycloak",
    openIdConnectUrl = "${oauth.openId.url}",
    scheme = "bearer",
    type = SecuritySchemeType.OPENIDCONNECT,
    in = SecuritySchemeIn.HEADER
)
public class GatewayServerApplication {

  public static void main(String[] args) {
    SpringApplication.run(GatewayServerApplication.class, args);
  }

  @Bean
  RouteLocator routeLocator(RouteLocatorBuilder builder) {
    return builder.routes()
        .route(p -> p.path("/forum/**")
            .filters(f -> f
                .rewritePath("/forum/(?<remaining>.*)", "/${remaining}")
                .addRequestHeader("Time-Requested", LocalDateTime.now().toString())
                .circuitBreaker(config -> config
                    .setName("usersCircuitBreaker")
                    .setFallbackUri("forward:/contact-support")))
            .uri("lb://USERS"))
        .build();
  }

}
