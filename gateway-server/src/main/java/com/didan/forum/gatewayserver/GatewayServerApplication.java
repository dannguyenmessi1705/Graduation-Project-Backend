package com.didan.forum.gatewayserver;

import static org.springframework.cloud.gateway.support.RouteMetadataUtils.CONNECT_TIMEOUT_ATTR;
import static org.springframework.cloud.gateway.support.RouteMetadataUtils.RESPONSE_TIMEOUT_ATTR;

import io.github.resilience4j.circuitbreaker.CircuitBreakerConfig;
import io.github.resilience4j.timelimiter.TimeLimiterConfig;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeIn;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import io.swagger.v3.oas.annotations.servers.Server;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Objects;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.circuitbreaker.resilience4j.ReactiveResilience4JCircuitBreakerFactory;
import org.springframework.cloud.circuitbreaker.resilience4j.Resilience4JConfigBuilder;
import org.springframework.cloud.client.circuitbreaker.Customizer;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.gateway.filter.ratelimit.KeyResolver;
import org.springframework.cloud.gateway.filter.ratelimit.RedisRateLimiter;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpMethod;
import reactor.core.publisher.Mono;

@SpringBootApplication
@EnableDiscoveryClient
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
        ),
        @Server(
            description = "Production server",
            url = "${app.api.url}"
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
@Slf4j
public class GatewayServerApplication {

  public static void main(String[] args) {
    SpringApplication.run(GatewayServerApplication.class, args);
  }

  @Bean
  RouteLocator routeLocator(RouteLocatorBuilder builder) {
    return builder.routes()
        .route(p -> p.path("/forum/users/**")
            .filters(f -> f
                .rewritePath("/forum/users/(?<remaining>.*)", "/users/${remaining}")
                .addRequestHeader("Time-Requested", LocalDateTime.now().toString())
                .retry(retryConfig -> retryConfig
                    .setRetries(3)
                    .setMethods(HttpMethod.GET)
                    .setBackoff(Duration.ofMillis(500), Duration.ofMillis(2000), 2, true)
                )
                .requestRateLimiter(rateLimiter -> rateLimiter
                    .setKeyResolver(userKeyResolver())
                    .setRateLimiter(redisRateLimiter())
                )
                .circuitBreaker(config -> config
                    .setName("usersCircuitBreaker")
                    .setFallbackUri("forward:/contact-support"))
                .metadata(RESPONSE_TIMEOUT_ATTR, 15000)
                .metadata(CONNECT_TIMEOUT_ATTR, 20000))
            .uri("http://users:8080"))
        .route(p -> p.path("/forum/posts/**")
            .filters(f -> f
                .rewritePath("/forum/posts/(?<remaining>.*)", "/posts/${remaining}")
                .addRequestHeader("Time-Requested", LocalDateTime.now().toString())
                .retry(retryConfig -> retryConfig
                    .setRetries(3)
                    .setMethods(HttpMethod.GET)
                    .setBackoff(Duration.ofMillis(500), Duration.ofMillis(2000), 2, true)
                )
                .requestRateLimiter(rateLimiter -> rateLimiter
                    .setKeyResolver(userKeyResolver())
                    .setRateLimiter(redisRateLimiter())
                )
                .circuitBreaker(config -> config
                    .setName("postsCircuitBreaker")
                    .setFallbackUri("forward:/contact-support"))
                .metadata(RESPONSE_TIMEOUT_ATTR, 15000)
                .metadata(CONNECT_TIMEOUT_ATTR, 20000))
            .uri("http://posts:8090"))
        .route(p -> p.path("/forum/comments/**")
            .filters(f -> f
                .rewritePath("/forum/comments/(?<remaining>.*)", "/comments/${remaining}")
                .addRequestHeader("Time-Requested", LocalDateTime.now().toString())
                .retry(retryConfig -> retryConfig
                    .setRetries(3)
                    .setMethods(HttpMethod.GET)
                    .setBackoff(Duration.ofMillis(500), Duration.ofMillis(2000), 2, true)
                )
                .requestRateLimiter(rateLimiter -> rateLimiter
                    .setKeyResolver(userKeyResolver())
                    .setRateLimiter(redisRateLimiter())
                )
                .circuitBreaker(config -> config
                    .setName("commentsCircuitBreaker")
                    .setFallbackUri("forward:/contact-support"))
                .metadata(RESPONSE_TIMEOUT_ATTR, 15000)
                .metadata(CONNECT_TIMEOUT_ATTR, 20000))
            .uri("http://comments:9000"))
        .route(p -> p.path("/forum/notifications/**")
            .filters(f -> f
                .rewritePath("/forum/notifications/(?<remaining>.*)", "/notifications/${remaining}")
                .addRequestHeader("Time-Requested", LocalDateTime.now().toString())
                .retry(retryConfig -> retryConfig
                    .setRetries(3)
                    .setMethods(HttpMethod.GET)
                    .setBackoff(Duration.ofMillis(500), Duration.ofMillis(2000), 2, true)
                )
                .requestRateLimiter(rateLimiter -> rateLimiter
                    .setKeyResolver(userKeyResolver())
                    .setRateLimiter(redisRateLimiter())
                )
                .circuitBreaker(config -> config
                    .setName("notificationsCircuitBreaker")
                    .setFallbackUri("forward:/contact-support"))
                .metadata(RESPONSE_TIMEOUT_ATTR, 15000)
                .metadata(CONNECT_TIMEOUT_ATTR, 20000))
            .uri("http://notifications:9010"))
        .build();
  }

  @Bean
  public Customizer<ReactiveResilience4JCircuitBreakerFactory> globalCustomConfiguration() {
    return factory -> factory.configureDefault(id -> new Resilience4JConfigBuilder(id)
        .timeLimiterConfig(TimeLimiterConfig.custom().timeoutDuration(Duration.ofSeconds(30)).cancelRunningFuture(true).build())
        .circuitBreakerConfig(CircuitBreakerConfig.ofDefaults())
        .build());
  }

  @Bean
  public KeyResolver userKeyResolver() {
    return exchange -> {
      log.info("Request from {}", Objects.requireNonNull(Objects.requireNonNull(exchange.getRequest().getLocalAddress()).getHostName()));
      return Mono.just(Objects.requireNonNull(exchange.getRequest().getRemoteAddress()).getHostName());
    };
  }

  @Bean
  public RedisRateLimiter redisRateLimiter() {
    return new RedisRateLimiter(150, 300, 1);
  }

}
