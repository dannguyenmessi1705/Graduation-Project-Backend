package com.didan.forum.comments.service.impl;

import com.didan.forum.comments.constant.VoteType;
import com.didan.forum.comments.dto.CommentInteractionScoreMessage;
import com.didan.forum.comments.dto.client.UserResponseDto;
import com.didan.forum.comments.dto.response.CommentVoteResponseDto;
import com.didan.forum.comments.entity.comment.CommentEntity;
import com.didan.forum.comments.entity.comment.CommentVoteEntity;
import com.didan.forum.comments.exception.ErrorActionException;
import com.didan.forum.comments.repository.comment.CommentVoteRepository;
import com.didan.forum.comments.service.ICommentService;
import com.didan.forum.comments.service.ICommentVoteService;
import com.didan.forum.comments.service.client.PostsFeignClient;
import com.didan.forum.comments.service.client.UsersFeignClient;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class CommentVoteServiceImpl implements ICommentVoteService {
  private final ICommentService commentService;
  private final CommentVoteRepository commentVoteRepository;
  private final UsersFeignClient usersFeignClient;
  private final PostsFeignClient postsFeignClient;
  private final StreamBridge streamBridge;

  @Override
  public void voteComment(String commentId, String userId, String voteType) {
    validateVoteType(voteType);
    CommentEntity comment = commentService.getCommentById(commentId);

    Optional<CommentVoteEntity> commentVote =
        commentVoteRepository.findCommentVoteEntityByComment_IdAndUserId(commentId, userId);
    if (commentVote.isPresent()) {
      if (commentVote.get().getVoteType().getName().equals(voteType.toLowerCase())) {
        log.info("User {} already voted comment {}", userId, commentId);
        throw new ErrorActionException("User already voted comment");
      } else {
        log.info("User {} change vote comment {} with vote {}", userId, commentId, voteType);
        commentVote.get().setVoteType(VoteType.fromString(voteType));
        commentVoteRepository.save(commentVote.get());
        CommentInteractionScoreMessage commentInteractionScoreMessage = CommentInteractionScoreMessage.builder()
            .commentId(commentId)
            .interactionScore(VoteType.UPVOTE.getName().equals(voteType.toLowerCase()) ? 2L : -2L)
            .build();
        streamBridge.send("sendCommentScore-out-0", commentInteractionScoreMessage);
      }
    } else {
      log.info("User {} vote comment {}", userId, commentId);
      commentVoteRepository.save(CommentVoteEntity.builder()
          .comment(comment)
          .userId(userId)
          .voteType(VoteType.fromString(voteType))
          .build());
      CommentInteractionScoreMessage commentInteractionScoreMessage = CommentInteractionScoreMessage.builder()
          .commentId(commentId)
          .interactionScore(VoteType.UPVOTE.getName().equals(voteType.toLowerCase()) ? 1L : -1L)
          .build();
      streamBridge.send("sendCommentScore-out-0", commentInteractionScoreMessage);
    }
  }

  @Override
  public void revokeVoteComment(String commentId, String userId) {
    commentService.checkCommentExist(commentId);
    if (Boolean.FALSE.equals(commentService.checkCommentExist(commentId))) {
      throw new ErrorActionException("Comment not found");
    }
    Optional<CommentVoteEntity> commentVote =
        commentVoteRepository.findCommentVoteEntityByComment_IdAndUserId(commentId, userId);
    if (commentVote.isPresent()) {
      log.info("User {} revoke vote comment {}", userId, commentId);
      commentVoteRepository.delete(commentVote.get());
      CommentInteractionScoreMessage commentInteractionScoreMessage = CommentInteractionScoreMessage.builder()
          .commentId(commentId)
          .interactionScore(VoteType.UPVOTE.getName().equals(commentVote.get().getVoteType().getName()) ? -1L : 1L)
          .build();
      streamBridge.send("sendCommentScore-out-0", commentInteractionScoreMessage);
    } else {
      log.info("User {} not vote comment {}", userId, commentId);
      throw new ErrorActionException("User not vote comment");
    }
  }

  @Override
  public Long countVoteComment(String commentId, String voteType) {
    validateVoteType(voteType);
    return commentVoteRepository.countCommentVoteEntityByComment_IdAndVoteTypeIsLike(commentId,
        VoteType.fromString(voteType));
  }

  @Override
  public List<CommentVoteResponseDto> getVotesComment(String commentId, String voteType) {
    validateVoteType(voteType);
    return commentVoteRepository.findCommentVoteEntityByComment_IdAndVoteTypeIsLike(commentId,
            VoteType.fromString(voteType)).stream()
        .map(commentVoteEntity -> {
          UserResponseDto user = commentService.getUserData(commentVoteEntity.getUserId());
          if (user != null) {
            return CommentVoteResponseDto.builder()
                .userId(commentVoteEntity.getUserId())
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
