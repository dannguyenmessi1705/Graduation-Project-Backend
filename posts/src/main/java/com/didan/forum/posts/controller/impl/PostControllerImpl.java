package com.didan.forum.posts.controller.impl;

import com.didan.forum.posts.controller.IPostController;
import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.Status;
import com.didan.forum.posts.dto.request.CreatePostRequestDto;
import com.didan.forum.posts.dto.request.ReportPostDto;
import com.didan.forum.posts.dto.request.UpdatePostRequestDto;
import com.didan.forum.posts.dto.response.PostResponseDto;
import com.didan.forum.posts.filter.RequestContext;
import com.didan.forum.posts.service.IPostService;
import com.didan.forum.posts.service.IReportPostService;
import java.time.LocalDateTime;
import java.util.List;
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
  private final IReportPostService reportPostService;

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
  public ResponseEntity<GeneralResponse<PostResponseDto>> updatePost(
      String postId,
      UpdatePostRequestDto requestDto) {
    log.info("===== Start updating post =====");
    PostResponseDto responseEntity = postService.updatePost(RequestContext.getRequest().getHeader("X-User-Id"), postId, requestDto);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "Post updated successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseEntity), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<List<PostResponseDto>>> getPosts(String searchType,
      int page) {
    log.info("===== Start getting posts =====");
    List<PostResponseDto> responseEntity = postService.getPosts(searchType, page);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "Posts retrieved successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseEntity), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<PostResponseDto>> getPost(String postId) {
    log.info("===== Start getting post =====");
    PostResponseDto responseEntity = postService.getPost(postId);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "Post retrieved successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseEntity), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<List<PostResponseDto>>> searchPosts(
      String key, String searchType, int page) {
    log.info("===== Start searching posts =====");
    List<PostResponseDto> responseEntity = postService.searchPosts(key, searchType, page);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "Posts retrieved successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseEntity), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<List<PostResponseDto>>> getPostsByTopic(String topicId,
      String type,
      int page) {
    log.info("===== Start getting posts by topic =====");
    List<PostResponseDto> responseEntity = postService.getPostsByTopic(topicId, type, page);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "Posts retrieved successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseEntity), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<List<PostResponseDto>>> getPostsByUser(String userId,
      int page) {
    log.info("===== Start getting posts by user =====");
    List<PostResponseDto> responseEntity = postService.getPostsByUser(userId, page);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "Posts retrieved successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseEntity), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> deletePost(String postId) {
    log.info("===== Start deleting post =====");
    postService.deletePost(RequestContext.getRequest().getHeader("X-User-Id"), postId);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "Post deleted successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> deletePostByAdmin(String postId) {
    log.info("===== Start deleting post by admin =====");
    postService.deletePost(postId);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "Post deleted successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> reportPost(String postId,
      ReportPostDto reportPostDto) {
    log.info("===== Start reporting post =====");
    reportPostService.reportPost(RequestContext.getRequest().getHeader("X-User-Id"), postId, reportPostDto);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "Post reported successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }
}
