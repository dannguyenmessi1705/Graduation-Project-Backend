package com.didan.forum.chats.service.impl;

import com.didan.forum.chats.dto.request.CreateRoomRequestDto;
import com.didan.forum.chats.entity.chat.RoomEntity;
import com.didan.forum.chats.entity.chat.UserChatStatusEntity;
import com.didan.forum.chats.exception.ErrorActionException;
import com.didan.forum.chats.exception.ResourceAlreadyExistException;
import com.didan.forum.chats.repository.chat.RoomRepository;
import com.didan.forum.chats.repository.chat.UserChatStatusRepository;
import com.didan.forum.chats.service.IRoomService;
import com.didan.forum.chats.utils.MapperUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class RoomServiceImpl implements IRoomService {
  private final RoomRepository roomRepository;
  private final UserChatStatusRepository userChatStatusRepository;

  @Override
  public void createRoom(CreateRoomRequestDto requestDto) {
    roomRepository.findRoomsByUserCreatorIdOrUserJoinerId(requestDto.getUserCreatorId(),
        requestDto.getUserJoinerId()).ifPresentOrElse(rooms -> {
          log.info("Room already exists");
          throw new ResourceAlreadyExistException("Room already exists");
        }, () -> {
          log.info("Create room");
          RoomEntity roomEntity = MapperUtils.map(requestDto, RoomEntity.class);
          roomRepository.save(roomEntity);
          UserChatStatusEntity userChatStatusEntity1 = UserChatStatusEntity.builder()
              .room(roomEntity)
              .userId(requestDto.getUserCreatorId())
              .unreadCount(0L)
              .build();
          UserChatStatusEntity userChatStatusEntity2 = UserChatStatusEntity.builder()
              .room(roomEntity)
              .userId(requestDto.getUserJoinerId())
              .unreadCount(0L)
              .build();
          userChatStatusRepository.save(userChatStatusEntity1);
          userChatStatusRepository.save(userChatStatusEntity2);
        });
  }
}
