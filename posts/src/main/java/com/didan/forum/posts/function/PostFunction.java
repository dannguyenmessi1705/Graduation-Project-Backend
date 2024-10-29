package com.didan.forum.posts.function;

import java.util.function.Consumer;
import java.util.function.Function;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class PostFunction {
  @Bean
  public Function<String, String> listenPost() {
    return message -> {
      System.out.println("Post1: " + message);
      return message;
    };
  }

  @Bean
  public Consumer<String> receivePost() {
    return message -> System.out.println("Post2: " + message);
  }
}
