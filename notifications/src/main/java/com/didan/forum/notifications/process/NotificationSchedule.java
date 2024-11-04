package com.didan.forum.notifications.process;

import com.didan.forum.notifications.constant.NotifyTypeConstant;
import com.didan.forum.notifications.entity.notification.NotificationEntity;
import com.didan.forum.notifications.repository.notification.NotificationRepository;
import java.time.LocalDateTime;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Slf4j
@EnableScheduling
public class NotificationSchedule {

  private final NotificationRepository notificationRepository;

  @Scheduled(fixedDelayString = "${app.scheduled.fixedDelay.milliseconds}")
  @Transactional
  @Modifying
  public void updateNotificationStatus() {
    log.info("Updating notification status");
    List<NotificationEntity> notificationEntities = notificationRepository.findNotificationEntitiesByTypeAndUserIdIsNull(NotifyTypeConstant.ADMIN);
    notificationEntities.forEach(notificationEntity -> {
      if (notificationEntity.getCreatedAt().isBefore(LocalDateTime.now().minusDays(1)) && !notificationEntity.getIsRead()) {
        notificationEntity.setIsRead(true);
        notificationRepository.save(notificationEntity);
      }
    });
    log.info("Notification status updated");
  }
}
