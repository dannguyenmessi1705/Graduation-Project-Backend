package com.didan.forum.posts.service;

import com.didan.forum.posts.dto.request.CreatePostRequestDto;
import com.didan.forum.posts.dto.response.PostResponseDto;
import com.didan.forum.posts.entity.PostEntity;

public interface IPostService {
  void validatePost(String postId);
  PostEntity getPostById(String postId);
  PostResponseDto createNewPost(String userId, CreatePostRequestDto requestDto);
}
