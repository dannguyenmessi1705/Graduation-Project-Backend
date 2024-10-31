package com.didan.forum.comments.function;

import com.didan.forum.comments.dto.CommentInteractionScoreMessage;
import com.didan.forum.comments.repository.comment.CommentRepository;
import com.didan.forum.comments.service.VerifyPostService;
import java.util.function.Consumer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@Slf4j
public class CommentFunction {
  @Bean
  public Consumer<String> postDeleted(CommentRepository commentRepository, VerifyPostService verifyPostService) {
    return postId -> {
      log.info("Post {} is deleted, deleting all comments", postId);
      commentRepository.deleteCommentByPostId(postId);
      verifyPostService.invalidateCache(postId);
    };
  }

  @Bean
  public Consumer<CommentInteractionScoreMessage> listenCommentScore(CommentRepository commentRepository) {
    return comment -> {
      log.info("Updating comment {} score", comment.getCommentId());
      commentRepository.updateScoreComment(comment.getCommentId(), comment.getInteractionScore());
    };
  }
}
