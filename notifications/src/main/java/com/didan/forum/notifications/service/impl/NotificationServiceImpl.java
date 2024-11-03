package com.didan.forum.notifications.service.impl;

import com.didan.forum.notifications.entity.notification.NotificationEntity;
import com.didan.forum.notifications.repository.notification.NotificationRepository;
import com.didan.forum.notifications.service.INotificationService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Slf4j
@RequiredArgsConstructor
public class NotificationServiceImpl implements INotificationService {

  private final NotificationRepository notificationRepository;

  @Value("${app.pagination.default-size}")
  private Integer defaultPageSize;

  @Override
  public List<NotificationEntity> getAllNotifications(String userId, Integer page) {
    Pageable pageable = PageRequest.of(page, defaultPageSize);
    List<NotificationEntity> notifications = notificationRepository
        .findNotificationEntitiesByUserIdOrderByCreatedAtDesc(userId, pageable);
    if (notifications.isEmpty()) {
      log.info("No notifications found for user: {}", userId);
      return List.of();
    }
    return notifications;
  }

  @Override
  public List<NotificationEntity> getUnreadNotifications(String userId, Integer page) {
    Pageable pageable = PageRequest.of(page, defaultPageSize);
    List<NotificationEntity> notifications = notificationRepository
        .findNotificationEntitiesByUserIdAndIsReadIsFalseOrderByCreatedAtDesc(userId, pageable);
    if (notifications.isEmpty()) {
      log.info("No unread notifications found for user: {}", userId);
      return List.of();
    }
    return notifications;
  }

  @Override
  public Long getUnreadNotificationsCount(String userId) {
    return notificationRepository.countNotificationEntitiesByUserIdAndIsReadIsFalseOrderByCreatedAtDesc(userId);
  }

  @Override
  @Transactional
  @Modifying
  public void markAsRead(String userId, Long notificationId) {
    NotificationEntity notification = notificationRepository.findById(notificationId)
        .orElseThrow(() -> new RuntimeException("Notification not found"));
    if (!notification.getUserId().equals(userId)) {
      throw new RuntimeException("Notification does not belong to user");
    }
    notification.setIsRead(true);
    notificationRepository.save(notification);
  }

  @Override
  @Transactional
  @Modifying
  public void markAllAsRead(String userId) {
    List<NotificationEntity> notifications = notificationRepository
        .findNotificationEntitiesByUserIdAndIsReadIsFalseOrderByCreatedAtDesc(userId);
    notifications.forEach(notification -> notification.setIsRead(true));
    notificationRepository.saveAll(notifications);
  }

  @Override
  @Transactional
  @Modifying
  public void deleteNotification(String userId, Long notificationId) {
    NotificationEntity notification = notificationRepository.findById(notificationId)
        .orElseThrow(() -> new RuntimeException("Notification not found"));
    if (!notification.getUserId().equals(userId)) {
      throw new RuntimeException("Notification does not belong to user");
    }
    notificationRepository.delete(notification);
  }

  @Override
  @Transactional
  @Modifying
  public void deleteAllNotifications(String userId) {
    List<NotificationEntity> notifications = notificationRepository
        .findNotificationEntitiesByUserIdOrderByCreatedAtDesc(userId);
    notificationRepository.deleteAll(notifications);
  }
}
