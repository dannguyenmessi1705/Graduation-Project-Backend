package com.didan.forum.comments.service;

import com.didan.forum.comments.dto.request.ReportCommentDto;

public interface IReportCommentService {
  void reportComment(String userId, String postId, ReportCommentDto reportCommentDto);

}
