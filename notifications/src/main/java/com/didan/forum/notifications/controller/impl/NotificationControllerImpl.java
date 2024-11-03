package com.didan.forum.notifications.controller.impl;

import com.didan.forum.notifications.controller.INotificationController;
import com.didan.forum.notifications.dto.Status;
import com.didan.forum.notifications.dto.response.GeneralResponse;
import com.didan.forum.notifications.entity.notification.NotificationEntity;
import com.didan.forum.notifications.filter.RequestContext;
import com.didan.forum.notifications.service.INotificationService;
import java.time.LocalDateTime;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@Slf4j
public class NotificationControllerImpl implements INotificationController {

  private final INotificationService notificationService;

  @Override
  public ResponseEntity<GeneralResponse<List<NotificationEntity>>> getAllNotifications(
      Integer page) {
    log.info("========== Get all notifications ==========");
    List<NotificationEntity> notifications = notificationService.getAllNotifications(
        RequestContext.getRequest().getHeader("X-User-Id"), page);

    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value()
        , "Retrieved all notifications successfully", LocalDateTime.now());

    return new ResponseEntity<>(new GeneralResponse<>(status, notifications), HttpStatus.OK);
  }
}
