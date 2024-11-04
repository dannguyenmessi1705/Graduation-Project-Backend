package com.didan.forum.posts.service.impl;

import com.didan.forum.posts.constant.NotifyTypeConstant;
import com.didan.forum.posts.constant.ReportType;
import com.didan.forum.posts.dto.NotificationKafkaCommon;
import com.didan.forum.posts.dto.request.ReportPostDto;
import com.didan.forum.posts.entity.post.PostEntity;
import com.didan.forum.posts.entity.report.ReportEntity;
import com.didan.forum.posts.repository.report.ReportRepository;
import com.didan.forum.posts.service.IPostService;
import com.didan.forum.posts.service.IReportPostService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReportPostServiceImpl implements IReportPostService {
  private final ReportRepository reportRepository;
  private final IPostService postService;

  @Override
  public void reportPost(String userId, String postId, ReportPostDto reportPostDto) {
    log.info("User {} is reporting post {}", userId, postId);
    PostEntity post = postService.validatePost(postId);
    ReportEntity reportEntity = ReportEntity.builder()
        .reportContent(reportPostDto.getContent())
        .subjectReportId(userId)
        .objectId(postId)
        .reportType(ReportType.POST)
        .build();
    reportRepository.save(reportEntity);
    NotificationKafkaCommon notificationKafkaCommon = NotificationKafkaCommon.builder()
        .userId(post.getAuthorId())
        .type(NotifyTypeConstant.REPORT)
        .title("Someone reported your post")
        .content(post.getTitle().substring(0, Math.min(post.getTitle().length(), 50)) + "...")
        .link("/posts/" + post.getId())
        .build();
  }
}
