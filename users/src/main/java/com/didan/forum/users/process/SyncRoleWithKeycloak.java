package com.didan.forum.users.process;

import com.didan.forum.users.entity.RoleEntity;
import com.didan.forum.users.entity.keycloak.RoleKeycloakEntity;
import com.didan.forum.users.repository.RoleRepository;
import com.didan.forum.users.service.IKeycloakRoleService;
import com.didan.forum.users.utils.MapperUtils;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
@EnableScheduling
public class SyncRoleWithKeycloak {
  private final RoleRepository roleRepository;
  private final IKeycloakRoleService keycloakRoleService;

  // Lập lịch cho việc đồng bộ dữ liệu giữa hệ thống và Keycloak mỗi 5 phút
  @Scheduled(initialDelay = 0, fixedDelayString = "${app.schedule.fixedDelay.milliseconds}")
  public void syncRole() {
    log.info("Start to sync role with Keycloak");
    List<RoleKeycloakEntity> roleKeycloakEntities = keycloakRoleService.getAllRolesFromKeycloak();
    List<RoleEntity> roleEntities = MapperUtils.mapList(roleKeycloakEntities, RoleEntity.class);
    roleRepository.saveAll(roleEntities);
    log.info("Finish to sync role with Keycloak");
  }
}
