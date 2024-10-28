package com.didan.forum.users.controller.impl;

import com.didan.forum.users.controller.IRoleController;
import com.didan.forum.users.dto.Status;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.entity.user.RoleEntity;
import com.didan.forum.users.filter.RequestContext;
import com.didan.forum.users.service.IRoleService;
import java.time.LocalDateTime;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@Slf4j
public class RoleControllerImpl implements IRoleController {

  private final IRoleService roleService;

  @Override
  public ResponseEntity<GeneralResponse<List<RoleEntity>>> getRoles(String userId) {
    log.info("========Get roles of user========");
    List<RoleEntity> roles = roleService.queryRolesOfUser(userId);
    Status status = new Status(RequestContext.getRequest().getRequestURI(), HttpStatus.OK.value(), "Retrieved "
        + "roles of user", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, roles), HttpStatus.OK);
  }
}
