package com.didan.forum.notifications.controller.impl;

import com.didan.forum.notifications.controller.INotificationController;
import com.didan.forum.notifications.dto.Status;
import com.didan.forum.notifications.dto.request.CreateNotificationRequestDto;
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

  @Override
  public ResponseEntity<GeneralResponse<List<NotificationEntity>>> getUnreadNotifications(
      Integer page) {
    log.info("========== Get unread notifications ==========");
    List<NotificationEntity> notifications = notificationService.getUnreadNotifications(
        RequestContext.getRequest().getHeader("X-User-Id"), page);

    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(),
        "Retrieved unread notifications successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, notifications), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Long>> getUnreadNotificationsCount() {
    log.info("========== Get unread notifications count ==========");
    Long count = notificationService.getUnreadNotificationsCount(
        RequestContext.getRequest().getHeader("X-User-Id"));

    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(),
        "Retrieved unread notifications count successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, count), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> markAsRead(Long notificationId) {
    log.info("========== Mark notification as read ==========");
    notificationService.markAsRead(RequestContext.getRequest().getHeader("X-User-Id"), notificationId);

    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(),
        "Marked notification as read successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> markAllAsRead() {
    log.info("========== Mark all notifications as read ==========");
    notificationService.markAllAsRead(RequestContext.getRequest().getHeader("X-User-Id"));

    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(),
        "Marked all notifications as read successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> deleteNotification(Long notificationId) {
    log.info("========== Delete notification ==========");
    notificationService.deleteNotification(RequestContext.getRequest().getHeader("X-User-Id"), notificationId);

    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(),
        "Deleted notification successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> deleteAllNotifications() {
    log.info("========== Delete all notifications ==========");
    notificationService.deleteAllNotifications(RequestContext.getRequest().getHeader("X-User-Id"));

    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(),
        "Deleted all notifications successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<NotificationEntity>> createNotificationByAdmin(CreateNotificationRequestDto requestDto) {
    log.info("========== Create notification by admin ==========");
    NotificationEntity notification = notificationService.createNotificationByAdmin(requestDto);

    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.CREATED.value(),
        "Created notification by admin successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, notification), HttpStatus.CREATED);
  }
}
