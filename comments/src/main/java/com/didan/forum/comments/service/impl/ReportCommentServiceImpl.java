package com.didan.forum.comments.service.impl;

import com.didan.forum.comments.constant.ReportType;
import com.didan.forum.comments.dto.request.ReportCommentDto;
import com.didan.forum.comments.entity.report.ReportEntity;
import com.didan.forum.comments.exception.ErrorActionException;
import com.didan.forum.comments.repository.report.ReportRepository;
import com.didan.forum.comments.service.ICommentService;
import com.didan.forum.comments.service.IReportCommentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class ReportCommentServiceImpl implements IReportCommentService {
  private final ReportRepository reportRepository;
  private final ICommentService commentService;

  @Override
  public void reportComment(String userId, String commentId, ReportCommentDto reportCommentDto) {
    log.info("User {} is reporting post {}", userId, commentId);
    if (Boolean.FALSE.equals(commentService.checkCommentExist(commentId))) {
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
  }

}
