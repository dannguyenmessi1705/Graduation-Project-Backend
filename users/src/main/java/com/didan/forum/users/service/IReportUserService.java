package com.didan.forum.users.service;

import com.didan.forum.users.dto.request.ReportUserDto;

public interface IReportUserService {
  void reportUser(String userId, String userReportedId, ReportUserDto reportPostDto);

}
