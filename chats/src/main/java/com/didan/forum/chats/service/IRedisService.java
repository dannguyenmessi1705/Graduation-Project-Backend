package com.didan.forum.chats.service;

import com.fasterxml.jackson.core.type.TypeReference;

public interface IRedisService {
  <T> void setCache(String cacheName, String key, T value);
  <T> void setCache(String cacheName, String key, T value, long expireTime);
  <T> T getCache(String cacheName, String key, Class<T> objectClass);
  <T> T getCache(String cacheName, String key, TypeReference<T> typeReference);
  void deleteCache(String cacheName, String key);
}
