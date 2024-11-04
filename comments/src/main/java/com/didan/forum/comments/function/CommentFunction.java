package com.didan.forum.comments.function;

import com.didan.forum.comments.constant.NotifyTypeConstant;
import com.didan.forum.comments.dto.CommentInteractionScoreMessage;
import com.didan.forum.comments.dto.CreateRequestNotificationKafkaCommon;
import com.didan.forum.comments.dto.NotificationKafkaCommon;
import com.didan.forum.comments.dto.client.PostResponseDto;
import com.didan.forum.comments.repository.comment.CommentRepository;
import com.didan.forum.comments.service.PostClientService;
import com.didan.forum.comments.service.VerifyPostService;
import java.util.function.Consumer;
import java.util.function.Function;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.stream.function.StreamBridge;
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

  @Bean
  public Consumer<CreateRequestNotificationKafkaCommon> listenRequestToCreateNotification(CommentRepository commentRepository,
      PostClientService postClientService, StreamBridge streamBridge) {
    return createRequestNotificationKafkaCommon -> {
      log.info("Create request notification received: {}", createRequestNotificationKafkaCommon);
      PostResponseDto post = postClientService.getPostDetail(createRequestNotificationKafkaCommon.getPostId());
      if (post == null) {
        log.error("Post {} not found", createRequestNotificationKafkaCommon.getPostId());
      } else {
        NotificationKafkaCommon notificationKafkaCommon = NotificationKafkaCommon.builder()
            .userId(post.getAuthor().getId())
            .title("Someone commented on your post")
            .content(createRequestNotificationKafkaCommon.getCommentContent().substring(0, Math.min(createRequestNotificationKafkaCommon.getCommentContent().length(), 50)) + "...")
            .type(NotifyTypeConstant.COMMENT)
            .link("/posts/" + post.getId())
            .build();
        streamBridge.send("sendNotification-out-0", notificationKafkaCommon);
      }
    };
  }
}
