package com.didan.forum.notifications.repository.notification;

import com.didan.forum.notifications.entity.notification.NotificationEntity;
import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NotificationRepository extends JpaRepository<NotificationEntity, Long> {

  List<NotificationEntity> findNotificationEntitiesByUserIdOrderByCreatedAtDesc(String userId
      , Pageable pageable);

  List<NotificationEntity> findNotificationEntitiesByUserIdOrderByCreatedAtDesc(String userId);

  List<NotificationEntity> findNotificationEntitiesByUserIdAndIsReadIsFalseOrderByCreatedAtDesc(
      String userId, Pageable pageable);

  List<NotificationEntity> findNotificationEntitiesByUserIdAndIsReadIsFalseOrderByCreatedAtDesc(
      String userId);

  Long countNotificationEntitiesByUserIdAndIsReadIsFalseOrderByCreatedAtDesc(String userId);


}
