package com.didan.forum.comments.service.impl;

import com.didan.forum.comments.constant.NotifyTypeConstant;
import com.didan.forum.comments.constant.ReportType;
import com.didan.forum.comments.dto.NotificationKafkaCommon;
import com.didan.forum.comments.dto.request.ReportCommentDto;
import com.didan.forum.comments.entity.comment.CommentEntity;
import com.didan.forum.comments.entity.report.ReportEntity;
import com.didan.forum.comments.exception.ErrorActionException;
import com.didan.forum.comments.repository.report.ReportRepository;
import com.didan.forum.comments.service.ICommentService;
import com.didan.forum.comments.service.IReportCommentService;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class ReportCommentServiceImpl implements IReportCommentService {
  private final ReportRepository reportRepository;
  private final ICommentService commentService;
  private final StreamBridge streamBridge;

  @Override
  public void reportComment(String userId, String commentId, ReportCommentDto reportCommentDto) {
    log.info("User {} is reporting post {}", userId, commentId);
    CommentEntity comment = commentService.getCommentById(commentId);
    if (comment == null) {
      log.error("Comment {} not found", commentId);
      throw new ErrorActionException("Comment not found");
    }
    ReportEntity reportEntity = ReportEntity.builder()
        .reportContent(reportCommentDto.getContent())
        .subjectReportId(userId)
        .objectId(commentId)
        .reportType(ReportType.COMMENT)
        .build();
    reportRepository.save(reportEntity);

    NotificationKafkaCommon notificationKafkaCommon = NotificationKafkaCommon.builder()
        .userId(comment.getAuthorId())
        .title("Someone reported your comment")
        .content(comment.getContent().substring(0, Math.min(comment.getContent().length(), 50)) + "...")
        .type(NotifyTypeConstant.REPORT)
        .link("/comments/get/" + comment.getId())
        .build();
    log.info("Sending notification to user {}", comment.getAuthorId());
     streamBridge.send("sendNotification-out-0", notificationKafkaCommon);
  }

}
