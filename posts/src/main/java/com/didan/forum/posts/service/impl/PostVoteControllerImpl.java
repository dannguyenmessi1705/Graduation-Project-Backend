package com.didan.forum.posts.service.impl;

import com.didan.forum.posts.dto.response.PostVoteResponseDto;
import com.didan.forum.posts.repository.PostRepository;
import com.didan.forum.posts.repository.PostVoteRepository;
import com.didan.forum.posts.service.IPostService;
import com.didan.forum.posts.service.IPostVoteService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class PostVoteControllerImpl implements IPostVoteService {
  private IPostService postService;
  private PostVoteRepository postVoteRepository;

  @Override
  public void votePost(String postId, String userId, String voteType) {

  }

  @Override
  public void revokeVotePost(String postId, String userId) {

  }

  @Override
  public Long countVotePost(String postId, String voteType) {
    return 0L;
  }

  @Override
  public List<PostVoteResponseDto> getVotesPost(String postId, String voteType) {
    return List.of();
  }
}
