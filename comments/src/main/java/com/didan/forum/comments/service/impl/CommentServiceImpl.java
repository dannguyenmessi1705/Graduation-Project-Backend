package com.didan.forum.comments.service.impl;

import com.didan.forum.comments.dto.request.CreateCommentRequestDto;
import com.didan.forum.comments.dto.response.CommentResponseDto;
import com.didan.forum.comments.repository.comment.CommentRepository;
import com.didan.forum.comments.service.ICommentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class CommentServiceImpl implements ICommentService {
  private final CommentRepository commentRepository;

  @Override
  public CommentResponseDto createComment(String userId, CreateCommentRequestDto requestDto) {
    return null;
  }


}
