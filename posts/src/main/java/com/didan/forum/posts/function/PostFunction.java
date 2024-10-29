package com.didan.forum.posts.function;

import com.didan.forum.posts.dto.PostInteractionScoreMessage;
import com.didan.forum.posts.repository.post.PostRepository;
import java.util.function.Consumer;
import java.util.function.Function;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Slf4j
@Configuration
public class PostFunction {

  @Bean
  public Consumer<PostInteractionScoreMessage> listenPostScore(PostRepository postRepository) {
    return message -> {
      log.info("Calculate post score: {}", message);
      postRepository.updateByIdAndInteractionScore(message.getPostId(),
          message.getInteractionScore());
    };
  }
}
