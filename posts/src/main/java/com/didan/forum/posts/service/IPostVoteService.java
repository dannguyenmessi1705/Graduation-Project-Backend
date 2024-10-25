package com.didan.forum.posts.service;

import com.didan.forum.posts.dto.response.PostVoteResponseDto;
import java.util.List;

public interface IPostVoteService {
  void votePost(String postId, String userId, String voteType);
  void revokeVotePost(String postId, String userId);
  Long countVotePost(String postId, String voteType);
  List<PostVoteResponseDto> getVotesPost(String postId, String voteType);
}
