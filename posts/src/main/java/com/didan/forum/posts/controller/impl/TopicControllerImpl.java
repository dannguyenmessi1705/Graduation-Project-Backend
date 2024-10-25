package com.didan.forum.posts.controller.impl;

import com.didan.forum.posts.controller.ITopicController;
import com.didan.forum.posts.dto.GeneralResponse;
import com.didan.forum.posts.dto.Status;
import com.didan.forum.posts.dto.request.CreateTopicRequestDto;
import com.didan.forum.posts.dto.response.TopicResponseDto;
import com.didan.forum.posts.service.ITopicService;
import jakarta.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
public class TopicControllerImpl implements ITopicController {
  private final ITopicService topicService;

  @Override
  public ResponseEntity<GeneralResponse<TopicResponseDto>> createTopic(
      CreateTopicRequestDto requestDto, HttpServletRequest request) {
    log.info("======Create Topic======");
    TopicResponseDto responseDto = topicService.createTopicByAdmin(requestDto);
    Status status = new Status(request.getRequestURI(), HttpStatus.CREATED.value(), "Topic "
        + "created successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.CREATED);
  }

  @Override
  public ResponseEntity<GeneralResponse<List<TopicResponseDto>>> getAllTopics(HttpServletRequest request) {
    log.info("======Get All Topics======");
    List<TopicResponseDto> topicEntities = topicService.getAllTopics();
    Status status = new Status(request.getRequestURI(), HttpStatus.OK.value(), "Retrieved all "
        + "topics successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, topicEntities), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<List<TopicResponseDto>>> getTopicsByName(String name, HttpServletRequest request) {
    log.info("======Get Topics By Name======");
    List<TopicResponseDto> topicEntities = topicService.searchTopicsByName(name);
    Status status = new Status(request.getRequestURI(), HttpStatus.OK.value(), "Retrieved topics "
        + "by name successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, topicEntities), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<TopicResponseDto>> getTopicDetails(String topicId, HttpServletRequest request) {
    log.info("======Get Topic Details======");
    TopicResponseDto topicEntity = topicService.getTopicById(topicId);
    Status status = new Status(request.getRequestURI(), HttpStatus.OK.value(), "Retrieved topic "
        + "details successfully",
        LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, topicEntity), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<TopicResponseDto>> updateTopic(String topicId,
      CreateTopicRequestDto requestDto, HttpServletRequest request) {
    log.info("======Update Topic======");
    TopicResponseDto responseDto = topicService.updateTopicByAdmin(topicId, requestDto);
    Status status = new Status(request.getRequestURI(), HttpStatus.OK.value(), "Topic updated "
        + "successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, responseDto), HttpStatus.OK);
  }

  @Override
  public ResponseEntity<GeneralResponse<Void>> deleteTopic(String topicId,
      HttpServletRequest request) {
    log.info("======Delete Topic======");
    topicService.deleteTopicByAdmin(topicId);
    Status status = new Status(request.getRequestURI(), HttpStatus.OK.value(), "Topic deleted "
        + "successfully", LocalDateTime.now());
    return new ResponseEntity<>(new GeneralResponse<>(status, null), HttpStatus.OK);
  }
}
