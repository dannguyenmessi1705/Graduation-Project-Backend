package com.didan.forum.users.service.impl;

import com.didan.forum.users.constant.NotifyTypeConstant;
import com.didan.forum.users.constant.ReportType;
import com.didan.forum.users.dto.NotificationKafkaCommon;
import com.didan.forum.users.dto.request.ReportUserDto;
import com.didan.forum.users.dto.response.UserResponseDto;
import com.didan.forum.users.entity.report.ReportEntity;
import com.didan.forum.users.repository.report.ReportRepository;
import com.didan.forum.users.service.IReportUserService;
import com.didan.forum.users.service.IUserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReportUserServiceImpl implements IReportUserService {
  private final ReportRepository reportRepository;
  private final IUserService userService;
  private final StreamBridge streamBridge;

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
    NotificationKafkaCommon notificationKafkaCommon = NotificationKafkaCommon.builder()
        .userId(userReportedId)
        .title("Someone reported to your behavior in the forum")
        .content("We received a report about your behavior in the forum. Please check it out.")
        .type(NotifyTypeConstant.REPORT)
        .link("/users/detail/" + reportEntity)
        .build();
    streamBridge.send("sendNotification-out-0", notificationKafkaCommon);
  }
}
