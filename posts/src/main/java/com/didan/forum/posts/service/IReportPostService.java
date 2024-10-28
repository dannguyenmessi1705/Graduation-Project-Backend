package com.didan.forum.posts.service;

import com.didan.forum.posts.dto.request.ReportPostDto;

public interface IReportPostService {
  void reportPost(String userId, String postId, ReportPostDto reportPostDto);

}
