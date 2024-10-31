package com.didan.forum.comments.service;

import com.didan.forum.comments.dto.request.CreateCommentRequestDto;
import com.didan.forum.comments.dto.response.CommentResponseDto;

public interface ICommentService {
  CommentResponseDto createComment(String userId, CreateCommentRequestDto requestDto);
}
