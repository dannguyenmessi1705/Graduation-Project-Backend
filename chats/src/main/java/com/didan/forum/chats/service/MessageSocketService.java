package com.didan.forum.chats.service;

import com.didan.forum.chats.dto.CreateMessageProducer;
import com.didan.forum.chats.dto.request.CreateMessageRequestDto;
import com.didan.forum.chats.entity.chat.MessageEntity;
import com.didan.forum.chats.entity.chat.RoomEntity;
import com.didan.forum.chats.exception.ErrorActionException;
import com.didan.forum.chats.exception.ResourceNotFoundException;
import com.didan.forum.chats.repository.chat.MessageRepository;
import com.didan.forum.chats.repository.chat.RoomRepository;
import com.didan.forum.chats.service.minio.MinioService;
import com.didan.forum.chats.utils.MapperUtils;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
@Slf4j
public class MessageSocketService {
  private final StreamBridge streamBridge;
  private final MinioService minioService;
  private final RoomRepository roomRepository;
  private final MessageRepository messageRepository;

  @Value("${minio.bucketName}")
  private String bucketName;

  public void sendMessage(CreateMessageRequestDto requestDto) {
    RoomEntity roomEntity =
        roomRepository.findById(requestDto.getRoomId()).orElseThrow(() -> new ResourceNotFoundException("Room not found"));
    List<String> filesPath = new ArrayList<>();
    if (requestDto.getFiles() != null && requestDto.getFiles().length > 0) {
      log.info("Uploading files to Minio");
      minioService.createBucket(bucketName);
      for (MultipartFile file : requestDto.getFiles()) {
        String fileName = file.getOriginalFilename();
        if (!StringUtils.hasText(fileName)) {
          throw new ErrorActionException("File name is empty");
        }
        String filePath =
            fileName.split("\\.")[0] + "_" + System.currentTimeMillis() + "." + fileName.split("\\.")[1];
        String contentType = file.getContentType();
        minioService.uploadFile(bucketName, file, filePath, contentType);
        filesPath.add(filePath);
      }
      log.info("Files uploaded successfully");
    }

    CreateMessageProducer messageProducer = MapperUtils.map(requestDto, CreateMessageProducer.class);
    messageProducer.setFiles(!filesPath.isEmpty() ?
        filesPath.stream().map(this::getUrlMaterial).toList() :
        null);
    streamBridge.send("sendChat-out-0", messageProducer);

    MessageEntity messageEntity = MessageEntity
        .builder()
        .id(requestDto.getId())
        .content(requestDto.getContent())
        .fileAttached(filesPath)
        .isRead(false)
        .senderId(requestDto.getSenderId())
        .receiverId(requestDto.getReceiverId())
        .room(roomEntity)
        .build();

    messageRepository.save(messageEntity);

    // Update user chat status
    streamBridge.send("updateCountUnread-out-0", messageProducer);
  }

  public void joinAction(CreateMessageRequestDto requestDto) {
    roomRepository.findById(requestDto.getRoomId()).orElseThrow(() -> new ResourceNotFoundException("Room not found"));
    CreateMessageProducer messageProducer = MapperUtils.map(requestDto, CreateMessageProducer.class);
    streamBridge.send("notifyJoin-out-0", messageProducer);
  }

  public String getUrlMaterial(String path) {
    String url = minioService.getPresignedObjectUrl(bucketName, path);
    return minioService.getUTF8ByURLDecoder(url);
  }
}
