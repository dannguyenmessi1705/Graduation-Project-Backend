package com.didan.forum.posts.service;

import com.didan.forum.posts.entity.PostEntity;

public interface IPostService {
  void validatePost(String postId);
  PostEntity getPostById(String postId);
}
