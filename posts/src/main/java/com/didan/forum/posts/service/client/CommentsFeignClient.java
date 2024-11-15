package com.didan.forum.posts.service.client;

import com.didan.forum.posts.dto.GeneralResponse;
import jakarta.validation.constraints.NotBlank;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "comments", url = "http://comments-service:9000", fallback = CommentsFallback.class)
public interface CommentsFeignClient {
  @GetMapping("/comments/count/{postId}")
  ResponseEntity<GeneralResponse<Long>> countComments(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId);
}
