package com.didan.forum.gatewayserver;

import java.time.LocalDateTime;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class GatewayServerApplication {

  public static void main(String[] args) {
    SpringApplication.run(GatewayServerApplication.class, args);
  }

  @Bean
  RouteLocator routeLocator(RouteLocatorBuilder builder) {
    return builder.routes()
        .route(p -> p.path("/forum/**")
            .filters(f -> f.rewritePath("/forum/(?<remaining>.*)", "/${remaining}")
                .addRequestHeader("Time-Requested", LocalDateTime.now().toString())
                .circuitBreaker(config -> config.setName("usersCircuitBreaker")
                    .setFallbackUri("forward:/contact-support")))
            .uri("lb://USERS"))
        .build();
  }

}
