package com.didan.forum.posts.controller.impl;

import com.didan.forum.posts.controller.IPostVoteController;
import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.Status;
import com.didan.forum.posts.dto.response.PostVoteResponseDto;
import com.didan.forum.posts.filter.RequestContext;
import com.didan.forum.posts.service.IPostVoteService;
import com.didan.forum.posts.service.client.UsersFeignClient;
import jakarta.servlet.http.HttpServletRequest;
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
public class PostVoteControllerImpl implements IPostVoteController {
  private final IPostVoteService postVoteService;

  @Override
  public ResponseEntity<GeneralResponse<Void>> votePost(String postId, String type) {
    log.info("======Vote Post======");
    postVoteService.votePost(postId, RequestContext.getRequest().getHeader("X-User-Id"), type);
    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.CREATED.value(), "Vote post successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.CREATED);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> revokeVote(String postId) {
    log.info("======Revoke Vote Post======");
    postVoteService.revokeVotePost(postId, RequestContext.getRequest().getHeader("X-User-Id"));
    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.OK.value(), "Revoke vote post successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Long>> countVotes(String postId, String type) {
    log.info("======Count Votes======");
    Long count = postVoteService.countVotePost(postId, type);
    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.OK.value(), "Count votes successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, count), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<List<PostVoteResponseDto>>> getVotesType(String postId,
      String type) {
    log.info("======Get Votes Type======");
    List<PostVoteResponseDto> votes = postVoteService.getVotesPost(postId, type);
    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.OK.value(), "Get votes type successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, votes), HttpStatus.OK);
  }
}
