package com.didan.forum.comments.service.impl;

import com.didan.forum.comments.constant.NotifyTypeConstant;
import com.didan.forum.comments.constant.RedisCacheConstant;
import com.didan.forum.comments.constant.SortType;
import com.didan.forum.comments.constant.VoteType;
import com.didan.forum.comments.dto.CreateRequestNotificationKafkaCommon;
import com.didan.forum.comments.dto.NotificationKafkaCommon;
import com.didan.forum.comments.dto.PostInteractionScoreMessage;
import com.didan.forum.comments.dto.client.UserResponseDto;
import com.didan.forum.comments.dto.request.CreateCommentRequestDto;
import com.didan.forum.comments.dto.response.CommentResponseDto;
import com.didan.forum.comments.dto.response.CommentResponseDto.UserInfo;
import com.didan.forum.comments.dto.response.GeneralResponse;
import com.didan.forum.comments.entity.comment.CommentEntity;
import com.didan.forum.comments.exception.ErrorActionException;
import com.didan.forum.comments.exception.ResourceNotFoundException;
import com.didan.forum.comments.repository.comment.CommentRepository;
import com.didan.forum.comments.service.ICommentService;
import com.didan.forum.comments.service.IRedisService;
import com.didan.forum.comments.service.VerifyPostService;
import com.didan.forum.comments.service.client.UsersFeignClient;
import com.didan.forum.comments.service.minio.MinioService;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
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
public class CommentServiceImpl implements ICommentService {
  private final CommentRepository commentRepository;
  private final VerifyPostService verifyPostService;
  private final UsersFeignClient usersFeignClient;
  private final IRedisService redisService;
  private final MinioService minioService;
  private final StreamBridge streamBridge;

  @Value("${minio.bucketName}")
  private String bucketName;

  @Value("${app.pagination.defaultSize}")
  private int defaultSize;

  public CommentServiceImpl(
      CommentRepository commentRepository,
      VerifyPostService verifyPostService,
      @Qualifier("com.didan.forum.comments.service.client.UsersFeignClient") UsersFeignClient usersFeignClient,
      IRedisService redisService,
      MinioService minioService,
      StreamBridge streamBridge) {
    this.commentRepository = commentRepository;
    this.verifyPostService = verifyPostService;
    this.usersFeignClient = usersFeignClient;
    this.redisService = redisService;
    this.minioService = minioService;
    this.streamBridge = streamBridge;
  }

  @Override
  public CommentResponseDto createComment(String userId, CreateCommentRequestDto requestDto) {
    if (!verifyPostService.verifyPost(requestDto.getPostId())) {
      throw new ResourceNotFoundException("Post not found");
    }
    UserResponseDto user = getUserData(userId);
    if (StringUtils.hasText(requestDto.getReplyToCommentId()) && Boolean.FALSE.equals(checkCommentExist(requestDto.getReplyToCommentId()))) {
      throw new ResourceNotFoundException("Comment not found");
    }

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

    CommentEntity commentEntity = CommentEntity.builder()
        .postId(requestDto.getPostId())
        .replyToCommentId(requestDto.getReplyToCommentId())
        .authorId(userId)
        .content(requestDto.getContent())
        .interactionScore(0L)
        .filesAttached(filesPath)
        .build();

    CommentEntity savedComment = commentRepository.save(commentEntity);

    PostInteractionScoreMessage postInteractionScoreMessage = PostInteractionScoreMessage.builder()
        .postId(requestDto.getPostId())
        .interactionScore(1L)
        .build();
    log.info("Sending message to update post score {}", postInteractionScoreMessage);
    streamBridge.send("sendPostScore-out-0", postInteractionScoreMessage);

    log.info("Sending message to update comment action {}", savedComment.getPostId());
    streamBridge.send("commentAction-out-0", savedComment.getPostId());

    CreateRequestNotificationKafkaCommon requestNotificationKafkaCommon = CreateRequestNotificationKafkaCommon.builder()
        .commentId(savedComment.getId())
        .ownerCommentId(savedComment.getAuthorId())
        .userCommentId(userId)
        .postId(savedComment.getPostId())
        .commentContent(savedComment.getContent())
        .build();
    log.info("Sending message to create notification {}", requestNotificationKafkaCommon);
    streamBridge.send("sendRequestToCreateNotification-out-0", requestNotificationKafkaCommon);

    return CommentResponseDto.builder()
        .id(savedComment.getId())
        .postId(savedComment.getPostId())
        .replyToCommentId(savedComment.getReplyToCommentId())
        .content(savedComment.getContent())
        .createdAt(savedComment.getCreatedAt())
        .updatedAt(savedComment.getUpdatedAt())
        .fileAttachments(savedComment.getFilesAttached() != null ?
            savedComment.getFilesAttached().stream().map(this::getUrlMaterial).toList() :
            List.of())
        .totalUpvotes(0L)
        .totalDownvotes(0L)
        .author(UserInfo.builder()
            .id(user.getId())
            .username(user.getUsername())
            .email(user.getEmail())
            .build())
        .build();
  }

  @Override
  public Boolean checkCommentExist(String commentId) {
    return commentRepository.existsById(commentId);
  }

  @Override
  public List<CommentResponseDto> getCommentsByPost(String postId, String type, int page) {
    if (!verifyPostService.verifyPost(postId)) {
      throw new ResourceNotFoundException("Post not found");
    }
    Pageable pageable = PageRequest.of(page, defaultSize);
    Page<CommentEntity> comments;
    if (SortType.NEW.name().equalsIgnoreCase(type)) {
      comments = commentRepository.findCommentByPostOrderTimeDesc(postId, pageable);
    } else if (SortType.HOT.name().equalsIgnoreCase(type)) {
      comments = commentRepository.findCommentByPostOrderInteraction(postId, pageable);
    } else {
      comments = commentRepository.findCommentByPostOrderTimeAsc(postId, pageable);
    }
    return comments.getTotalElements() != 0 ? mapListComment(comments.getContent()) : List.of();
  }

  @Override
  public void deleteComment(String userId, String commentId) {
    CommentEntity comment = commentRepository.findById(commentId)
        .orElseThrow(() -> new ResourceNotFoundException("Comment not found"));
    if (!comment.getAuthorId().equals(userId)) {
      throw new ErrorActionException("You are not the author of this comment");
    }
    commentRepository.delete(comment);
    PostInteractionScoreMessage postInteractionScoreMessage = PostInteractionScoreMessage.builder()
        .postId(comment.getPostId())
        .interactionScore(-1L)
        .build();
    streamBridge.send("sendPostScore-out-0", postInteractionScoreMessage);
    streamBridge.send("commentAction-out-0", comment.getPostId());
  }

  @Override
  public void deleteCommentByAdmin(String commentId) {
    CommentEntity comment = commentRepository.findById(commentId)
        .orElseThrow(() -> new ResourceNotFoundException("Comment not found"));
    commentRepository.delete(comment);
    PostInteractionScoreMessage postInteractionScoreMessage = PostInteractionScoreMessage.builder()
        .postId(comment.getPostId())
        .interactionScore(-1L)
        .build();
    log.info("Sending message to update post score {}", postInteractionScoreMessage);
    streamBridge.send("sendPostScore-out-0", postInteractionScoreMessage);

    log.info("Sending message to update comment action {}", comment.getPostId());
    streamBridge.send("commentAction-out-0", comment.getPostId());

    NotificationKafkaCommon notificationKafkaCommon = NotificationKafkaCommon.builder()
        .userId(comment.getAuthorId())
        .type(NotifyTypeConstant.ADMIN)
        .title("Your comment is not following the community rules and has been deleted")
        .content(comment.getContent().substring(0, Math.min(comment.getContent().length(), 50)) + "...")
        .link("/comments/get/" + comment.getId())
        .build();
    log.info("Sending message to create notification {}", notificationKafkaCommon);
    streamBridge.send("sendNotification-out-0", notificationKafkaCommon);
  }

  @Override
  public CommentResponseDto getComment(String commentId) {
    CommentEntity comment = commentRepository.findCommentEntityById(commentId)
        .orElseThrow(() -> new ResourceNotFoundException("Comment not found"));
    return mapComment(comment);
  }

  @Override
  public CommentEntity getCommentById(String commentId) {
    return commentRepository.findCommentEntityById(commentId)
        .orElseThrow(() -> new ResourceNotFoundException("Comment not found"));
  }

  @Override
  public Long countCommentsByPost(String postId) {
    if (!verifyPostService.verifyPost(postId)) {
      throw new ResourceNotFoundException("Post not found");
    }
    return commentRepository.countCommentEntitiesByPostId(postId);
  }

  private List<CommentResponseDto> mapListComment(List<CommentEntity> comments) {
    return comments.stream().map(this::mapComment).toList();
  }

  private CommentResponseDto mapComment(CommentEntity comment) {
    UserResponseDto user = getUserData(comment.getAuthorId());
    UserInfo author = new UserInfo();
    if (user != null) {
      author = UserInfo.builder()
          .id(user.getId())
          .username(user.getUsername())
          .email(user.getEmail())
          .build();
    } else {
      author = UserInfo.builder()
          .id(comment.getAuthorId())
          .username("Unknown")
          .email("Unknown")
          .build();
    }
    return CommentResponseDto.builder()
        .id(comment.getId())
        .postId(comment.getPostId())
        .replyToCommentId(comment.getReplyToCommentId())
        .content(comment.getContent())
        .createdAt(comment.getCreatedAt())
        .updatedAt(comment.getUpdatedAt())
        .fileAttachments(comment.getFilesAttached() != null ?
            comment.getFilesAttached().stream().map(this::getUrlMaterial).toList() :
            List.of())
        .totalUpvotes(comment.getVotes().stream().filter(v -> v.getVoteType().equals(VoteType.UPVOTE)).count())
        .totalDownvotes(comment.getVotes().stream().filter(v -> v.getVoteType().equals(VoteType.DOWNVOTE)).count())
        .author(author)
        .build();
  }

  @Override
  public UserResponseDto getUserData(String userId) {
    UserResponseDto cachedUser = redisService.getCache(RedisCacheConstant.USER_CACHE.getCacheName(), userId, UserResponseDto.class);
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

  public String getUrlMaterial(String path) {
    String url = minioService.getPresignedObjectUrl(bucketName, path);
    return minioService.getUTF8ByURLDecoder(url);
  }

}
