package com.didan.forum.notifications;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import io.swagger.v3.oas.annotations.servers.Server;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableFeignClients
@EnableDiscoveryClient
@EnableJpaAuditing(auditorAwareRef = "auditAware")
@OpenAPIDefinition(
    info = @Info(
        title = "Microservice for managing notifications of Z'forum",
        description = "This microservice is responsible for managing notifications of Z'forum",
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
        summary = "Microservice for managing notifications of Z'forum"
    ),
    servers = {
        @Server(
            description = "Local server",
            url = "http://localhost:9010"
        ),
        @Server(
            description = "Gateway server",
            url = "http://localhost:8072/forum"
        ),
        @Server(
            description = "Production server",
            url = "${app.api.url}"
        )
    }
)
@SecurityScheme(
    name = "Keycloak",
    scheme = "bearer",
    type = SecuritySchemeType.HTTP,
    bearerFormat = "JWT"
)
public class NotificationsApplication {

  public static void main(String[] args) {
    SpringApplication.run(NotificationsApplication.class, args);
  }

}
