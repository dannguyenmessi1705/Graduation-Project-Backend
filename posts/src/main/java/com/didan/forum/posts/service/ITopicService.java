package com.didan.forum.posts.service;

import com.didan.forum.posts.dto.request.CreateTopicRequestDto;
import com.didan.forum.posts.dto.response.TopicResponseDto;
import java.util.List;

public interface ITopicService {
  TopicResponseDto createTopicByAdmin(CreateTopicRequestDto createTopicRequestDto);
  TopicResponseDto getTopicById(String topicId);
  List<TopicResponseDto> getAllTopics(int page);
  List<TopicResponseDto> searchTopicsByName(String name, int page);
  TopicResponseDto updateTopicByAdmin(String topicId, CreateTopicRequestDto createTopicRequestDto);
  void deleteTopicByAdmin(String topicId);
}
