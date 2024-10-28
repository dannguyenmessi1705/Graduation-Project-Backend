package com.didan.forum.users.service.impl;

import com.didan.forum.users.constant.ReportType;
import com.didan.forum.users.dto.request.ReportUserDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import com.didan.forum.users.entity.report.ReportEntity;
import com.didan.forum.users.repository.report.ReportRepository;
import com.didan.forum.users.service.IReportUserService;
import com.didan.forum.users.service.IUserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReportUserServiceImpl implements IReportUserService {
  private final ReportRepository reportRepository;
  private final IUserService userService;

  @Override
  public void reportUser(String userId, String userReportedId, ReportUserDto reportPostDto) {
    log.info("User {} reported user {} with reason {}", userId, userReportedId, reportPostDto.getContent());
    UserResponseDto userReported = userService.getDetailUser(userReportedId);
    ReportEntity reportEntity = ReportEntity.builder()
        .reportContent(reportPostDto.getContent())
        .reportType(ReportType.USER)
        .subjectReportId(userId)
        .objectId(userReportedId)
        .build();
    reportRepository.save(reportEntity);
  }
}
