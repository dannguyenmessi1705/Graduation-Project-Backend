package com.didan.forum.notifications.service;

import com.didan.forum.notifications.entity.notification.NotificationEntity;
import java.util.List;

public interface INotificationService {
  List<NotificationEntity> getAllNotifications(String userId, Integer page);
  List<NotificationEntity> getUnreadNotifications(String userId, Integer page);
  Long getUnreadNotificationsCount(String userId);
  void markAsRead(String userId, Long notificationId);
  void markAllAsRead(String userId);
  void deleteNotification(String userId, Long notificationId);
  void deleteAllNotifications(String userId);
}
