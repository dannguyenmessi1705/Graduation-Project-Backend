package com.didan.forum.notifications.service.client;

import com.didan.forum.notifications.dto.client.UserResponseDto;
import com.didan.forum.notifications.dto.response.GeneralResponse;
import jakarta.validation.constraints.NotBlank;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(value = "users", url = "http://users-service:8080", fallback = UsersFallback.class)
public interface UsersFeignClient {
  @GetMapping(path = "users/detail/{userId}", produces = MediaType.APPLICATION_JSON_VALUE)
  ResponseEntity<GeneralResponse<UserResponseDto>> getDetailUser(
      @NotBlank(message = "blank.field.userid") @PathVariable("userId") String userId);

  @GetMapping("/users/check/{userId}")
  ResponseEntity<GeneralResponse<Boolean>> checkUserExists(@NotBlank(message = "blank.field.userid") @PathVariable(
      "userId") String userId);
}
