package com.didan.forum.posts.service;

import com.didan.forum.posts.dto.request.CreatePostRequestDto;
import com.didan.forum.posts.dto.request.UpdatePostRequestDto;
import com.didan.forum.posts.dto.response.PostResponseDto;
import com.didan.forum.posts.entity.PostEntity;
import java.util.List;

public interface IPostService {
  void validatePost(String postId);
  PostEntity getPostById(String postId);
  PostResponseDto createNewPost(String userId, CreatePostRequestDto requestDto);
  PostResponseDto updatePost(String userId, String postId, UpdatePostRequestDto requestDto);
  void deletePost(String userId, String postId);
  List<PostResponseDto> getPosts(String searchType, int page);
  PostResponseDto getPost(String postId);
  List<PostResponseDto> searchPosts(String key, String searchType, int page);
  List<PostResponseDto> getPostsByTopic(String topicId, String type, int page);
  List<PostResponseDto> getPostsByUser(String userId, int page);
}
