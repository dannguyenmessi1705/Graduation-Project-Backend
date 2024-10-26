package com.didan.forum.posts.service.impl;

import com.didan.forum.posts.entity.PostEntity;
import com.didan.forum.posts.exception.ResourceNotFoundException;
import com.didan.forum.posts.repository.PostRepository;
import com.didan.forum.posts.service.IPostService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class PostServiceImpl implements IPostService {
  private final PostRepository postRepository;

  @Override
  public void validatePost(String postId) {
    log.info("Validate post with id: {}", postId);
    postRepository.findById(postId).orElseThrow(() -> {
      log.error("Post with id {} not found", postId);
      return new ResourceNotFoundException("Post with id " + postId + " not found");
    });
  }

  @Override
  public PostEntity getPostById(String postId) {
    return postRepository.findById(postId).orElseThrow(() -> {
      log.error("Post with id {} not found", postId);
      return new ResourceNotFoundException("Post with id " + postId + " not found");
    });
  }
}
