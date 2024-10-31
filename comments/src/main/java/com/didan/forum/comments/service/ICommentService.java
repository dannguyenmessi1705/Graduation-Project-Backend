package com.didan.forum.comments.service;

import com.didan.forum.comments.dto.client.UserResponseDto;
import com.didan.forum.comments.dto.request.CreateCommentRequestDto;
import com.didan.forum.comments.dto.response.CommentResponseDto;
import com.didan.forum.comments.entity.comment.CommentEntity;
import java.util.List;

public interface ICommentService {
  CommentResponseDto createComment(String userId, CreateCommentRequestDto requestDto);
  List<CommentResponseDto> getCommentsByPost(String postId, String type, int page);
  void deleteComment(String userId, String commentId);
  void deleteCommentByAdmin(String commentId);
  CommentResponseDto getComment(String commentId);
  CommentEntity getCommentById(String commentId);
  Boolean checkCommentExist(String commentId);
  UserResponseDto getUserData(String userId);
  Long countCommentsByPost(String postId);
}
