package com.didan.forum.posts.service.impl;

import com.didan.forum.posts.constant.RedisCacheConstant;
import com.didan.forum.posts.constant.SearchType;
import com.didan.forum.posts.constant.SortType;
import com.didan.forum.posts.constant.VoteType;
import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.client.UserResponseDto;
import com.didan.forum.posts.dto.request.CreatePostRequestDto;
import com.didan.forum.posts.dto.request.UpdatePostRequestDto;
import com.didan.forum.posts.dto.response.PostResponseDto;
import com.didan.forum.posts.dto.response.PostResponseDto.UserInfo;
import com.didan.forum.posts.entity.post.PostEntity;
import com.didan.forum.posts.entity.post.TopicEntity;
import com.didan.forum.posts.exception.ErrorActionException;
import com.didan.forum.posts.exception.ResourceNotFoundException;
import com.didan.forum.posts.repository.post.PostRepository;
import com.didan.forum.posts.repository.post.TopicRepository;
import com.didan.forum.posts.service.IPostService;
import com.didan.forum.posts.service.IRedisService;
import com.didan.forum.posts.service.client.CommentsFeignClient;
import com.didan.forum.posts.service.client.UsersFeignClient;
import com.didan.forum.posts.service.minio.MinioService;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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
  private final IRedisService redisService;
  private final StreamBridge streamBridge;
  private final CommentsFeignClient commentsFeignClient;

  @Value("${minio.bucketName}")
  private String bucketName;

  @Value("${app.pagination.defaultSize}")
  private int defaultSize;

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
    UserResponseDto user = getUserData(userId);
    List<String> filesPath = new ArrayList<>();
    if (requestDto.getFiles() != null && requestDto.getFiles().length > 0) {
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
        .fileAttachments(newPost.getFilesAttached() != null ?
            newPost.getFilesAttached().stream().map(this::getUrlMaterial).toList() : List.of())
        .totalUpvotes(0L)
        .totalDownvotes(0L)
        .totalComments(0L)
        .createdAt(newPost.getCreatedAt())
        .updatedAt(newPost.getUpdatedAt())
        .build();
  }

  @Override
  public PostResponseDto updatePost(String userId, String postId, UpdatePostRequestDto requestDto) {
    PostEntity post = postRepository.findById(postId).orElseThrow(() -> {
      log.error("Post with id {} not found", postId);
      return new ResourceNotFoundException("Post with id " + postId + " not found");
    });
    if (!post.getAuthorId().equals(userId)) {
      log.error("User with id {} is not the author of post with id {}", userId, postId);
      throw new ErrorActionException("User is not the author of this post");
    }
    UserResponseDto user = getUserData(userId);
    post.setTitle(StringUtils.hasText(requestDto.getTitle()) ? requestDto.getTitle() : post.getTitle());
    post.setContent(StringUtils.hasText(requestDto.getContent()) ? requestDto.getContent() : post.getContent());
    List<String> filesPath = post.getFilesAttached();
    if (requestDto.getFiles() != null && requestDto.getFiles().length > 0) {
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
    post.setFilesAttached(filesPath);
    postRepository.save(post);
    log.info("Post with id {} updated successfully", postId);

    UserInfo author = new UserInfo();
    if (user != null) {
      author = UserInfo.builder()
          .id(user.getId())
          .username(user.getUsername())
          .email(user.getEmail())
          .build();
    } else {
      author = UserInfo.builder()
          .id(post.getAuthorId())
          .username("Unknown")
          .email("Unknown")
          .build();
    }
    return PostResponseDto.builder()
        .id(post.getId())
        .title(post.getTitle())
        .topicId(post.getTopic().getId())
        .content(post.getContent())
        .author(author)
        .fileAttachments(post.getFilesAttached())
        .totalUpvotes(post.getVotes().stream().filter(v -> v.getVoteType().equals(VoteType.UPVOTE)).count())
        .totalDownvotes(post.getVotes().stream().filter(v -> v.getVoteType().equals(VoteType.DOWNVOTE)).count())
        .totalComments(getTotalComments(post.getId()))
        .createdAt(post.getCreatedAt())
        .updatedAt(post.getUpdatedAt())
        .build();
  }

  @Override
  public void deletePost(String userId, String postId) {
    PostEntity post = postRepository.findById(postId).orElseThrow(() -> {
      log.error("Post with id {} not found", postId);
      return new ResourceNotFoundException("Post with id " + postId + " not found");
    });
    if (!post.getAuthorId().equals(userId)) {
      log.error("User with id {} is not the author of post with id {}", userId, postId);
      throw new ErrorActionException("User is not the author of this post");
    }
    postRepository.delete(post);
    streamBridge.send("postDeleted-out-0", postId);
    log.info("Post with id {} deleted successfully", postId);
  }

  @Override
  public void deletePost(String postId) {
    PostEntity post = postRepository.findById(postId).orElseThrow(() -> {
      log.error("Post with id {} not found", postId);
      return new ResourceNotFoundException("Post with id " + postId + " not found");
    });
    postRepository.delete(post);
    streamBridge.send("postDeleted-out-0", postId);
    log.info("Post with id {} deleted successfully", postId);
  }

  @Override
  public List<PostResponseDto> getPosts(String searchType, int page) {
    Pageable pageable = PageRequest.of(page, defaultSize);
    Page<PostEntity> posts;
    if (SortType.HOT.getType().equalsIgnoreCase(searchType)) {
      posts = postRepository.findAllByOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(
          pageable);
    } else {
      posts = postRepository.findAllByOrderByUpdatedAtDescCreatedAtDescTitleAsc(pageable);
    }
    return posts.getTotalElements() != 0 ? mapPostList(posts.stream().toList()) : List.of();
  }

  @Override
  public PostResponseDto getPost(String postId) {
    PostEntity post = postRepository.findById(postId).orElseThrow(() -> {
      log.error("Post with id {} not found", postId);
      return new ResourceNotFoundException("Post with id " + postId + " not found");
    });
    return mapPost(post);
  }

  @Override
  public List<PostResponseDto> searchPosts(String key, String searchType, int page) {
    Pageable pageable = PageRequest.of(page, defaultSize);
    Page<PostEntity> posts;
    if (SearchType.TITLE.getType().equalsIgnoreCase(searchType)) {
      posts = postRepository.findPostEntityByTitleContainingOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(
          key, pageable);
    } else {
      posts = postRepository.findPostEntityByContentContainingOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(
          key, pageable);
    }
    return posts.getTotalElements() != 0 ? mapPostList(posts.stream().toList()) : List.of();
  }

  @Override
  public List<PostResponseDto> getPostsByTopic(String topicId, String type, int page) {
    topicRepository.findById(topicId).orElseThrow(() -> {
      log.error("Topic with id {} not found", topicId);
      return new ResourceNotFoundException("Topic with id " + topicId + " not found");
    });
    Pageable pageable = PageRequest.of(page, defaultSize);
    Page<PostEntity> posts;
    if (SortType.HOT.getType().equalsIgnoreCase(type)) {
      posts = postRepository.findPostEntityByTopicIdOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(
          topicId, pageable);
    } else {
      posts = postRepository.findPostEntityByTopicIdOrderByUpdatedAtDescCreatedAtDesc(topicId, pageable);
    }
    return posts.getTotalElements() != 0 ? mapPostList(posts.stream().toList()) : List.of();
  }

  @Override
  public List<PostResponseDto> getPostsByUser(String userId, int page) {
    Pageable pageable = PageRequest.of(page, defaultSize);
    Page<PostEntity> posts = postRepository.findPostEntityByAuthorIdOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(
        userId, pageable);
    return posts.getTotalElements() != 0 ? mapPostList(posts.stream().toList()) : List.of();
  }

  @Override
  public Boolean checkPostExist(String postId) {
    return postRepository.existsById(postId);
  }

  private List<PostResponseDto> mapPostList(List<PostEntity> list) {
    return list.stream().map(this::mapPost).toList();
  }

  private PostResponseDto mapPost(PostEntity post) {
    UserResponseDto user = getUserData(post.getAuthorId());
    UserInfo author = new UserInfo();
    if (user != null) {
      author = UserInfo.builder()
          .id(user.getId())
          .username(user.getUsername())
          .email(user.getEmail())
          .build();
    } else {
      author = UserInfo.builder()
          .id(post.getAuthorId())
          .username("Unknown")
          .email("Unknown")
          .build();
    }
    return PostResponseDto.builder()
        .id(post.getId())
        .title(post.getTitle())
        .topicId(post.getTopic().getId())
        .content(post.getContent())
        .author(author)
        .fileAttachments(post.getFilesAttached() != null ?
            post.getFilesAttached().stream().map(this::getUrlMaterial).toList() : List.of())
        .totalUpvotes(post.getVotes().stream().filter(v -> v.getVoteType().equals(VoteType.UPVOTE)).count())
        .totalDownvotes(post.getVotes().stream().filter(v -> v.getVoteType().equals(VoteType.DOWNVOTE)).count())
        .totalComments(getTotalComments(post.getId()))
        .createdAt(post.getCreatedAt())
        .updatedAt(post.getUpdatedAt())
        .build();
  }

  public String getUrlMaterial(String path) {
    String url = minioService.getPresignedObjectUrl(bucketName, path);
    return minioService.getUTF8ByURLDecoder(url);
  }

  @Override
  public UserResponseDto getUserData(String userId) {
    UserResponseDto cachedUser = redisService.getCache(RedisCacheConstant.USER_CACHE.getCacheName(), userId,
        UserResponseDto.class);
    if (cachedUser != null) {
      return cachedUser;
    }
    ResponseEntity<GeneralResponse<UserResponseDto>> requestUsers =
        usersFeignClient.getDetailUser(userId);
    if (requestUsers.getStatusCode().is2xxSuccessful()) {
      UserResponseDto userResponseDto = Objects.requireNonNull(requestUsers.getBody()).getData();
      redisService.setCache(RedisCacheConstant.USER_CACHE.getCacheName(), userId, userResponseDto, 3600);
      return userResponseDto;
    } else {
      redisService.setCache(RedisCacheConstant.USER_CACHE.getCacheName(), userId, null, 3600);
      return null;
    }
  }

  private Long getTotalComments(String postId) {
    Long totalCommentsInCache = redisService.getCache(RedisCacheConstant.COMMENT_QUANTITY_CACHE.getCacheName(), postId
        , Long.class);
    if (totalCommentsInCache != null) {
      return totalCommentsInCache;
    }
    ResponseEntity<GeneralResponse<Long>> requestComments =
        commentsFeignClient.countComments(postId);
    if (requestComments.getStatusCode().is2xxSuccessful()) {
      Long totalComments = Objects.requireNonNull(requestComments.getBody()).getData();
      redisService.setCache(RedisCacheConstant.COMMENT_QUANTITY_CACHE.getCacheName(), postId, totalComments, 3600);
      return totalComments;
    } else {
      redisService.setCache(RedisCacheConstant.COMMENT_QUANTITY_CACHE.getCacheName(), postId, 0L, 3600);
      return 0L;
    }
  }
}
