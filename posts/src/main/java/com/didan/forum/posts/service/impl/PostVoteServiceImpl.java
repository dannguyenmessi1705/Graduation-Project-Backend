package com.didan.forum.posts.service.impl;

import com.didan.forum.posts.constant.NotifyTypeConstant;
import com.didan.forum.posts.constant.VoteType;
import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.NotificationKafkaCommon;
import com.didan.forum.posts.dto.PostInteractionScoreMessage;
import com.didan.forum.posts.dto.client.UserResponseDto;
import com.didan.forum.posts.dto.response.PostVoteResponseDto;
import com.didan.forum.posts.entity.post.PostEntity;
import com.didan.forum.posts.entity.post.PostVoteEntity;
import com.didan.forum.posts.exception.ErrorActionException;
import com.didan.forum.posts.repository.post.PostRepository;
import com.didan.forum.posts.repository.post.PostVoteRepository;
import com.didan.forum.posts.service.IPostService;
import com.didan.forum.posts.service.IPostVoteService;
import com.didan.forum.posts.service.client.UsersFeignClient;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class PostVoteServiceImpl implements IPostVoteService {
  private final IPostService postService;
  private final PostVoteRepository postVoteRepository;
  private final UsersFeignClient usersFeignClient;
  private final StreamBridge streamBridge;

  @Override
  public void votePost(String postId, String userId, String voteType) {
    validateVoteType(voteType);
    PostEntity post = postService.getPostById(postId);

    Optional<PostVoteEntity> postVote =
        postVoteRepository.findPostVoteEntityByPostIdAndUserId(postId,
        userId);
    if (postVote.isPresent()) {
      if (postVote.get().getVoteType().getName().equals(voteType.toLowerCase())) {
        log.info("User {} already voted post {}", userId, postId);
        throw new ErrorActionException("User already voted post");
      } else {
        log.info("User {} change vote post {} with vote {}", userId, postId, voteType);
        postVote.get().setVoteType(VoteType.fromString(voteType));
        postVoteRepository.save(postVote.get());
        PostInteractionScoreMessage postInteractionScoreMessage = PostInteractionScoreMessage.builder()
            .postId(postId)
            .interactionScore(VoteType.UPVOTE.getName().equals(voteType.toLowerCase()) ? 2L : -2L)
            .build();
        streamBridge.send("sendPostScore-out-0", postInteractionScoreMessage);
      }
    } else {
      log.info("User {} vote post {}", userId, postId);
      postVoteRepository.save(PostVoteEntity.builder()
          .post(post)
          .userId(userId)
          .voteType(VoteType.fromString(voteType))
          .build());
      PostInteractionScoreMessage postInteractionScoreMessage = PostInteractionScoreMessage.builder()
          .postId(postId)
          .interactionScore(VoteType.UPVOTE.getName().equals(voteType.toLowerCase()) ? 1L : -1L)
          .build();
      streamBridge.send("sendPostScore-out-0", postInteractionScoreMessage);
      NotificationKafkaCommon notificationKafkaCommon = NotificationKafkaCommon.builder()
          .userId(post.getAuthorId())
          .title(VoteType.UPVOTE.getName().equals(voteType.toLowerCase()) ? "Someone upvote your post" : "Someone downvote your post")
          .content(post.getTitle().substring(0, Math.min(post.getTitle().length(), 50)) + "...")
          .type(VoteType.UPVOTE.getName().equals(voteType.toLowerCase()) ? NotifyTypeConstant.VOTE_UP_POST : NotifyTypeConstant.VOTE_DOWN_POST)
          .link("/posts/" + post.getId())
          .build();
      streamBridge.send("sendNotification-out-0", notificationKafkaCommon);
    }
  }

  @Override
  public void revokeVotePost(String postId, String userId) {
    postService.validatePost(postId);
    Optional<PostVoteEntity> postVote =
        postVoteRepository.findPostVoteEntityByPostIdAndUserId(postId,
        userId);
    if (postVote.isPresent()) {
      log.info("User {} revoke vote post {}", userId, postId);
      postVoteRepository.delete(postVote.get());
      PostInteractionScoreMessage postInteractionScoreMessage = PostInteractionScoreMessage.builder()
          .postId(postId)
          .interactionScore(VoteType.UPVOTE.getName().equals(postVote.get().getVoteType().getName()) ? -1L : 1L)
          .build();
      streamBridge.send("sendPostScore-out-0", postInteractionScoreMessage);
    } else {
      log.info("User {} not vote post {}", userId, postId);
      throw new ErrorActionException("User not vote post");
    }
  }

  @Override
  public Long countVotePost(String postId, String voteType) {
    validateVoteType(voteType);
    return postVoteRepository.countPostVoteEntityByPostIdAndVoteTypeIsLike(postId,
        VoteType.fromString(voteType));
  }

  @Override
  public List<PostVoteResponseDto> getVotesPost(String postId, String voteType) {
    validateVoteType(voteType);
    return postVoteRepository.findPostVoteEntityByPostIdAndVoteTypeIsLike(postId,
        VoteType.fromString(voteType)).stream()
        .map(postVoteEntity -> {
          UserResponseDto user = postService.getUserData(postVoteEntity.getUserId());
          if (user != null) {
            return PostVoteResponseDto.builder()
                .userId(postVoteEntity.getUserId())
                .fullName(user.getFirstName() + " " + user.getLastName())
                .username(user.getUsername())
                .build();
          } else {
            return null;
          }
        })
        .toList();
  }

  void validateVoteType(String voteType) {
    if (!VoteType.UPVOTE.getName().equals(voteType.toLowerCase()) && !VoteType.DOWNVOTE.getName().equals(voteType.toLowerCase())) {
      throw new IllegalArgumentException("Invalid vote type");
    }
  }
}
