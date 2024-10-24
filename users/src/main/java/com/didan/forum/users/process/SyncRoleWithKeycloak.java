package com.didan.forum.users.process;

import com.didan.forum.users.entity.RoleEntity;
import com.didan.forum.users.entity.keycloak.RoleKeycloakEntity;
import com.didan.forum.users.repository.RoleRepository;
import com.didan.forum.users.service.IKeycloakRoleService;
import com.didan.forum.users.utils.MapperUtils;
import com.github.benmanes.caffeine.cache.CacheLoader;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.github.benmanes.caffeine.cache.LoadingCache;
import jakarta.annotation.PostConstruct;
import java.time.Duration;
import java.util.List;
import java.util.concurrent.TimeUnit;
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

  private LoadingCache<String, List<RoleEntity>> loadingCache;
  private static final int EXPIRETIME = 5;

  @PostConstruct
  public void init() {
    CacheLoader<String, List<RoleEntity>> loader = this::load;
    loadingCache = Caffeine.newBuilder()
        .maximumSize(Integer.MAX_VALUE)
        .expireAfterWrite(Duration.ofDays(EXPIRETIME))
        .evictionListener((key, value, cause) -> log.info("Evicting key: {}, value: {}, cause: {}", key, value, cause))
        .build(loader);
  }

  private List<RoleEntity> load(String key) {
    log.info("Get all roles from Keycloak");
    List<RoleKeycloakEntity> roleKeycloakEntities = keycloakRoleService.getAllRolesFromKeycloak();
    return MapperUtils.mapList(roleKeycloakEntities, RoleEntity.class);
  }

  // Lập lịch cho việc đồng bộ dữ liệu giữa hệ thống và Keycloak mỗi 5 phút
  @Scheduled(initialDelay = 0, fixedDelayString = "${app.schedule.fixedDelay.milliseconds}")
  public void syncRole() {
    log.info("Start to sync role with Keycloak");
    List<RoleEntity> roleEntities = loadingCache.get("roles-keycloak");
    roleRepository.saveAll(roleEntities);
    log.info("Finish to sync role with Keycloak");
  }

  public void evictCache() {
    loadingCache.invalidateAll();
  }

  public List<RoleEntity> getRoles() {
    return loadingCache.get("roles-keycloak");
  }
}
