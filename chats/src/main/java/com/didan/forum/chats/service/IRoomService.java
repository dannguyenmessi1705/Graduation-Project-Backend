package com.didan.forum.chats.service;

import com.didan.forum.chats.dto.request.CreateRoomRequestDto;

public interface IRoomService {
  void createRoom(CreateRoomRequestDto requestDto);
}
