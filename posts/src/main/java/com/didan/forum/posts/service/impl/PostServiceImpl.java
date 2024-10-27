package com.didan.forum.posts.service.impl;

import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.client.UserResponseDto;
import com.didan.forum.posts.dto.request.CreatePostRequestDto;
import com.didan.forum.posts.dto.response.PostResponseDto;
import com.didan.forum.posts.dto.response.PostResponseDto.UserInfo;
import com.didan.forum.posts.dto.response.TopicResponseDto;
import com.didan.forum.posts.entity.PostEntity;
import com.didan.forum.posts.entity.TopicEntity;
import com.didan.forum.posts.exception.ErrorActionException;
import com.didan.forum.posts.exception.ResourceNotFoundException;
import com.didan.forum.posts.repository.PostRepository;
import com.didan.forum.posts.repository.TopicRepository;
import com.didan.forum.posts.service.IPostService;
import com.didan.forum.posts.service.ITopicService;
import com.didan.forum.posts.service.client.UsersFeignClient;
import com.didan.forum.posts.service.minio.MinioService;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
@Slf4j
@RequiredArgsConstructor
public class PostServiceImpl implements IPostService {
  private final PostRepository postRepository;
  private final TopicRepository topicRepository;
  private final UsersFeignClient usersFeignClient;
  private final MinioService minioService;

  @Value("${minio.bucketName}")
  private String bucketName;

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

  @Override
  public PostResponseDto createNewPost(String userId, CreatePostRequestDto requestDto) {
    TopicEntity topic = topicRepository.findById(requestDto.getTopicId())
        .orElseThrow(() -> {
          log.error("Topic with id {} not found", requestDto.getTopicId());
          return new ResourceNotFoundException("Topic with id " + requestDto.getTopicId() + " not found");
        });
    ResponseEntity<GeneralResponse<UserResponseDto>> requestUsers =
        usersFeignClient.getDetailUser(userId);
    UserResponseDto user = Objects.requireNonNull(requestUsers.getBody()).getData();
    List<String> filesPath = new ArrayList<>();
    if (requestDto.getFiles().length > 0) {
      log.info("Uploading files to Minio");
      minioService.createBucket(bucketName);
      for (MultipartFile file : requestDto.getFiles()) {
        String fileName = file.getOriginalFilename();
        if (!StringUtils.hasText(fileName)) {
          throw new ErrorActionException("File name is empty");
        }
        String filePath =
            fileName.split("\\.")[0] + "_" + System.currentTimeMillis() + "." + fileName.split("\\.")[1];
        String contentType = file.getContentType();
        minioService.uploadFile(bucketName, file, filePath, contentType);
        filesPath.add(filePath);
      }
      log.info("Files uploaded successfully");
    }
    PostEntity newPost = PostEntity.builder()
        .title(requestDto.getTitle())
        .topic(topic)
        .content(requestDto.getContent())
        .authorId(user.getId())
        .filesAttached(filesPath)
        .interactionScore(0L)
        .votes(new ArrayList<>())
        .build();
    postRepository.save(newPost);
    log.info("Post created successfully");

    return PostResponseDto.builder()
        .id(newPost.getId())
        .title(newPost.getTitle())
        .topicId(newPost.getTopic().getId())
        .content(newPost.getContent())
        .author(UserInfo.builder()
            .id(user.getId())
            .email(user.getEmail())
            .username(user.getUsername())
            .build())
        .fileAttachments(newPost.getFilesAttached())
        .totalUpvotes(0L)
        .totalDownvotes(0L)
        .totalComments(0L)
        .createdAt(newPost.getCreatedAt())
        .updatedAt(newPost.getUpdatedAt())
        .build();
  }


  public String getUrlMaterial(String path) {
    String url = minioService.getPresignedObjectUrl(bucketName, path);
    return minioService.getUTF8ByURLDecoder(url);
  }
}
