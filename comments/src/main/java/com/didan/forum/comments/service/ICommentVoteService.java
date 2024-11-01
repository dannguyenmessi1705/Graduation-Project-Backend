package com.didan.forum.comments.service;

import com.didan.forum.comments.dto.response.CommentVoteResponseDto;
import java.util.List;

public interface ICommentVoteService {
  void voteComment(String commentId, String userId, String voteType);
  void revokeVoteComment(String commentId, String userId);
  Long countVoteComment(String commentId, String voteType);
  List<CommentVoteResponseDto> getVotesComment(String commentId, String voteType);
}
