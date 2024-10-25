package com.didan.forum.users.controller.impl;

import com.didan.forum.users.controller.IVerifyController;
import com.didan.forum.users.dto.Status;
import com.didan.forum.users.dto.request.ChangePasswordAdminDto;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.didan.forum.users.service.IVerifyService;
import jakarta.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
public class VerifyControllerImpl implements IVerifyController {
  private final IVerifyService verifyService;

  @Override
  public ResponseEntity<GeneralResponse<Void>> activateAccount(String token, HttpServletRequest request) {
    log.info("Activate account with token: {}", token);
    verifyService.activateUser(token);
    Status status = new Status(request.getRequestURI(), HttpStatus.OK.value(), "Account activated successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<ChangePasswordAdminDto>> resetPassword(String token, HttpServletRequest request) {
    log.info("Reset password with token: {}", token);
    ChangePasswordAdminDto responseDto = verifyService.resetPassword(token);
    Status status = new Status(request.getRequestURI(), HttpStatus.OK.value(), "Password reset successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.OK);
  }
}
