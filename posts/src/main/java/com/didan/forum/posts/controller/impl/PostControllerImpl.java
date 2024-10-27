package com.didan.forum.posts.controller.impl;

import com.didan.forum.posts.controller.IPostController;
import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.Status;
import com.didan.forum.posts.dto.request.CreatePostRequestDto;
import com.didan.forum.posts.dto.response.PostResponseDto;
import com.didan.forum.posts.filter.RequestContext;
import com.didan.forum.posts.service.IPostService;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
public class PostControllerImpl implements IPostController {
  private final IPostService postService;

  @Override
  public ResponseEntity<GeneralResponse<PostResponseDto>> createPost(
      CreatePostRequestDto requestDto) {
    log.info("===== Start creating post =====");
    PostResponseDto responseDto =
        postService.createNewPost(RequestContext.getRequest().getHeader("X-User-Id"), requestDto);
    Status status =
        new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.CREATED.value(), "Post"
            + " created successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.CREATED);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> updatePost() {
    return null;
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> getPosts() {
    return null;
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> getPost() {
    return null;
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> searchPosts() {
    return null;
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> getPostsByTopic() {
    return null;
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> deletePost() {
    return null;
  }
}
