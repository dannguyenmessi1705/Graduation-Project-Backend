package com.didan.forum.posts.service.impl;

import com.didan.forum.posts.constant.VoteType;
import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.client.UserResponseDto;
import com.didan.forum.posts.dto.response.PostVoteResponseDto;
import com.didan.forum.posts.entity.PostEntity;
import com.didan.forum.posts.entity.PostVoteEntity;
import com.didan.forum.posts.exception.ErrorActionException;
import com.didan.forum.posts.repository.PostVoteRepository;
import com.didan.forum.posts.service.IPostService;
import com.didan.forum.posts.service.IPostVoteService;
import com.didan.forum.posts.service.client.UsersFeignClient;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class PostVoteServiceImpl implements IPostVoteService {
  private final IPostService postService;
  private final PostVoteRepository postVoteRepository;
  private final UsersFeignClient usersFeignClient;

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
        log.info("User {} change vote post {}", userId, postId);
        postVote.get().setVoteType(VoteType.valueOf(voteType.toLowerCase()));
        postVoteRepository.save(postVote.get());
      }
    } else {
      log.info("User {} vote post {}", userId, postId);
      postVoteRepository.save(PostVoteEntity.builder()
          .post(post)
          .userId(userId)
          .voteType(VoteType.valueOf(voteType.toLowerCase()))
          .build());
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
    } else {
      log.info("User {} not vote post {}", userId, postId);
      throw new ErrorActionException("User not vote post");
    }
  }

  @Override
  public Long countVotePost(String postId, String voteType) {
    validateVoteType(voteType);
    return postVoteRepository.countPostVoteEntityByPostIdAndVoteTypeIsLike(postId,
        VoteType.valueOf(voteType.toLowerCase()));
  }

  @Override
  public List<PostVoteResponseDto> getVotesPost(String postId, String voteType) {
    validateVoteType(voteType);
    return postVoteRepository.findPostVoteEntityByPostIdAndVoteTypeIsLike(postId,
        VoteType.valueOf(voteType.toLowerCase())).stream()
        .map(postVoteEntity -> {
          ResponseEntity<GeneralResponse<UserResponseDto>> user =
              usersFeignClient.getDetailUser(postVoteEntity.getUserId());
          if (user.getStatusCode().is2xxSuccessful()) {
            UserResponseDto userResponseDto = Objects.requireNonNull(user.getBody()).getData();
            return PostVoteResponseDto.builder()
                .userId(postVoteEntity.getUserId())
                .fullName(userResponseDto.getFirstName() + " " + userResponseDto.getLastName())
                .username(userResponseDto.getUsername())
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
