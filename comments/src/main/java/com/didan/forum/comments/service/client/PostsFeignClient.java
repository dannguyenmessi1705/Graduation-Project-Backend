package com.didan.forum.comments.service.client;

import com.didan.forum.comments.dto.client.PostResponseDto;
import com.didan.forum.comments.dto.response.GeneralResponse;
import jakarta.validation.constraints.NotBlank;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "posts")
public interface PostsFeignClient {
  @GetMapping("/posts/exists/{postId}")
  ResponseEntity<GeneralResponse<Boolean>> checkPostExist(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId
  );

  @GetMapping("/posts/{postId}")
  ResponseEntity<GeneralResponse<PostResponseDto>> getPost(
      @NotBlank(message = "blank.field.postId") @PathVariable("postId") String postId
  );
}
