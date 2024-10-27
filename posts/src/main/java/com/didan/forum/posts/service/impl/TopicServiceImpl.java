package com.didan.forum.posts.service.impl;

import com.didan.forum.posts.dto.request.CreateTopicRequestDto;
import com.didan.forum.posts.dto.response.TopicResponseDto;
import com.didan.forum.posts.entity.TopicEntity;
import com.didan.forum.posts.exception.ResourceAlreadyExistException;
import com.didan.forum.posts.exception.ResourceNotFoundException;
import com.didan.forum.posts.repository.PostRepository;
import com.didan.forum.posts.repository.TopicRepository;
import com.didan.forum.posts.service.ITopicService;
import com.didan.forum.posts.utils.MapperUtils;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Slf4j
public class TopicServiceImpl implements ITopicService {

  private final TopicRepository topicRepository;
  private final PostRepository postRepository;

  @Value("${app.pagination.defaultSize}")
  private int defaultSize;

  @Override
  public TopicResponseDto createTopicByAdmin(CreateTopicRequestDto requestDto) {
    TopicEntity newTopic = new TopicEntity();
    topicRepository.findTopicEntityByName(requestDto.getName()).ifPresentOrElse(
        topicEntity -> {
          throw new ResourceAlreadyExistException("Topic with name " + requestDto.getName() + " already exists");
        },
        () -> {
          newTopic.setName(requestDto.getName());
          topicRepository.save(newTopic);
        }
    );
    return MapperUtils.map(newTopic, TopicResponseDto.class);
  }

  @Override
  public TopicResponseDto getTopicById(String topicId) {
    Optional<TopicEntity> topicEntity = topicRepository.findById(topicId);
    return topicEntity.map(entity -> {
      TopicResponseDto topicResponseDto = MapperUtils.map(entity, TopicResponseDto.class);
      Long postCount = postRepository.countPostEntityByTopic_Id(topicId);
      topicResponseDto.setTotalPosts(postCount);
      return topicResponseDto;
    }).orElseThrow(() -> {
      log.error("Topic with id {} not found", topicId);
      return new ResourceNotFoundException("Topic with id " + topicId + " not found");
    });
  }

  @Override
  public List<TopicResponseDto> getAllTopics(int page) {
    Pageable pageable = PageRequest.of(page, defaultSize);
    Page<TopicEntity> topics =
        topicRepository.findAllByOrderByPostCountDescUpdatedAtDescNameAsc(pageable);
    if (topics.isEmpty()) return List.of();
    return mapTopicList(topics.stream().toList());
  }

  @Override
  public List<TopicResponseDto> searchTopicsByName(String name, int page) {
    Pageable pageable = PageRequest.of(page, defaultSize);
    Page<TopicEntity> topics = topicRepository.findTopicByNameContain(name, pageable);
    if (topics.isEmpty()) return List.of();
    return mapTopicList(topics.stream().toList());
  }

  @Override
  @Transactional
  @Modifying
  public TopicResponseDto updateTopicByAdmin(String topicId,
      CreateTopicRequestDto createTopicRequestDto) {
    Optional<TopicEntity> topicEntity = topicRepository.findById(topicId);
    return topicEntity.map(entity -> {
      entity.setName(createTopicRequestDto.getName());
      topicRepository.save(entity);
      return MapperUtils.map(entity, TopicResponseDto.class);
    }).orElseThrow(() -> {
      log.error("Topic with id {} not found", topicId);
      return new ResourceNotFoundException("Topic with id " + topicId + " not found");
    });
  }

  @Override
  @Transactional
  @Modifying
  public void deleteTopicByAdmin(String topicId) {
    Optional<TopicEntity> topicEntity = topicRepository.findById(topicId);
    topicEntity.ifPresentOrElse(
        entity -> {
          topicRepository.delete(entity);
          log.info("Topic with id {} deleted successfully", topicId);
        },
        () -> {
          log.error("Topic with id {} not found", topicId);
          throw new ResourceNotFoundException("Topic with id " + topicId + " not found");
        }
    );
  }

  private List<TopicResponseDto> mapTopicList(List<TopicEntity> topics) {
    List<TopicResponseDto> topicsResponse = new ArrayList<>();
    topics.forEach(topicEntity -> {
      TopicResponseDto topicResponseDto = MapperUtils.map(topicEntity, TopicResponseDto.class);
      Long postCount = postRepository.countPostEntityByTopic_Id(topicEntity.getId());
      topicResponseDto.setTotalPosts(postCount);
      topicsResponse.add(topicResponseDto);
    });
    return topicsResponse;
  }
}
