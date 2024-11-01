package com.didan.forum.comments.controller.impl;

import com.didan.forum.comments.controller.ICommentController;
import com.didan.forum.comments.dto.Status;
import com.didan.forum.comments.dto.request.CreateCommentRequestDto;
import com.didan.forum.comments.dto.request.ReportCommentDto;
import com.didan.forum.comments.dto.response.CommentResponseDto;
import com.didan.forum.comments.dto.response.GeneralResponse;
import com.didan.forum.comments.filter.RequestContext;
import com.didan.forum.comments.service.ICommentService;
import com.didan.forum.comments.service.IReportCommentService;
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
public class CommentControllerImpl implements ICommentController {

  private final ICommentService commentService;
  private final IReportCommentService reportCommentService;

  @Override
  public ResponseEntity<GeneralResponse<CommentResponseDto>> createComment(
      CreateCommentRequestDto requestDto) {
    log.info("======Creating comment======");
    CommentResponseDto responseDto =
        commentService.createComment(RequestContext.getRequest().getHeader("X-User-Id"),
            requestDto);

    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.CREATED.value(), "Comment created successfully", LocalDateTime.now());

    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.CREATED);
  }

  @Override
  public ResponseEntity<GeneralResponse<List<CommentResponseDto>>> getCommentsByPost(String postId,
      String type, int page) {
    log.info("======Getting comments by post======");
    List<CommentResponseDto> responseDtoList = commentService.getCommentsByPost(postId, type, page);

    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.OK.value(), "Comments retrieved successfully", LocalDateTime.now());

    return new ResponseEntity<>(new GeneralResponse<>(status, responseDtoList), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> deleteComment(String commentId) {
    log.info("======Deleting comment======");
    commentService.deleteComment(RequestContext.getRequest().getHeader("X-User-Id"), commentId);

    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.OK.value(), "Comment deleted successfully", LocalDateTime.now());

    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> deleteCommentByAdmin(String commentId) {
    log.info("======Deleting comment by admin======");
    commentService.deleteCommentByAdmin(commentId);

    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.OK.value(), "Comment deleted successfully", LocalDateTime.now());

    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<CommentResponseDto>> getComment(String commentId) {
    log.info("======Getting comment======");
    CommentResponseDto responseDto = commentService.getComment(commentId);

    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.OK.value(), "Comment retrieved successfully", LocalDateTime.now());

    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Long>> countComments(String postId) {
    log.info("======Counting comments======");
    Long count = commentService.countCommentsByPost(postId);

    Status status = new Status(RequestContext.getRequest().getRequestURI(),
        HttpStatus.OK.value(), "Comments counted successfully", LocalDateTime.now());

    return new ResponseEntity<>(new GeneralResponse<>(status, count), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> reportComment(String commentId,
      ReportCommentDto requestDto) {
    log.info("======Reporting comment======");
    reportCommentService.reportComment(RequestContext.getRequest().getHeader("X-User-Id"),
        commentId, requestDto);

    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(),
        "Comment reported successfully", LocalDateTime.now());

    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }
}
