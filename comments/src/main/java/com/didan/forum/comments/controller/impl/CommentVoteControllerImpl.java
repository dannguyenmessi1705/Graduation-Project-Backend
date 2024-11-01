package com.didan.forum.comments.controller.impl;

import com.didan.forum.comments.controller.ICommentVoteController;
import com.didan.forum.comments.dto.Status;
import com.didan.forum.comments.dto.response.CommentVoteResponseDto;
import com.didan.forum.comments.dto.response.GeneralResponse;
import com.didan.forum.comments.filter.RequestContext;
import com.didan.forum.comments.service.ICommentVoteService;
import java.time.LocalDateTime;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
public class CommentVoteControllerImpl implements ICommentVoteController {

  private final ICommentVoteService commentVoteService;


  @Override
  public ResponseEntity<GeneralResponse<Void>> addVote(String commentId, String type) {
    log.info("======Voting {} on comment======", type);
    commentVoteService.voteComment(commentId, RequestContext.getRequest().getHeader("X-User-Id"), type);

    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.CREATED.value(), "Comment vote " + type + " created successfully",
        LocalDateTime.now());

    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.CREATED);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> revokeVote(String commentId) {
    log.info("======Revoking vote on comment======");
    commentVoteService.revokeVoteComment(commentId, RequestContext.getRequest().getHeader("X-User-Id"));

    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.OK.value(), "Comment vote revoked successfully", LocalDateTime.now());

    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Long>> getVoteQuantity(String commentId, String type) {
    log.info("======Getting vote quantity======");
    Long voteQuantity = commentVoteService.countVoteComment(commentId, type);

    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.OK.value(), "Vote quantity retrieved successfully", LocalDateTime.now());

    return new ResponseEntity<>(new GeneralResponse<>(status, voteQuantity), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<List<CommentVoteResponseDto>>> getVotes(String commentId,
      String type) {
    log.info("======Getting votes======");
    List<CommentVoteResponseDto> votes = commentVoteService.getVotesComment(commentId, type);

    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.OK.value(), "Votes retrieved successfully", LocalDateTime.now());

    return new ResponseEntity<>(new GeneralResponse<>(status, votes), HttpStatus.OK);
  }
}
