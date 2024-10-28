package com.didan.forum.posts.service.impl;

import com.didan.forum.posts.constant.ReportType;
import com.didan.forum.posts.dto.request.ReportPostDto;
import com.didan.forum.posts.entity.report.ReportEntity;
import com.didan.forum.posts.repository.report.ReportRepository;
import com.didan.forum.posts.service.IPostService;
import com.didan.forum.posts.service.IReportPostService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
    postService.validatePost(postId);
    ReportEntity reportEntity = ReportEntity.builder()
        .reportContent(reportPostDto.getContent())
        .subjectReportId(userId)
        .objectId(postId)
        .reportType(ReportType.POST)
        .build();
    reportRepository.save(reportEntity);
  }
}
