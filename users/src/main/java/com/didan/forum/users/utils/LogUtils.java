package com.didan.forum.users.utils;

import com.didan.forum.users.dto.Status;
import com.didan.forum.users.dto.response.GeneralResponse;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.introspect.JacksonAnnotationIntrospector;
import com.fasterxml.jackson.databind.util.StdDateFormat;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.util.ContentCachingResponseWrapper;

@Slf4j
@UtilityClass
public class LogUtils {

  private static final List<String> ignorePatterns;

  static {
    ignorePatterns = new ArrayList<>();
    ignorePatterns.add("(?<=\"password\":\")[^\"]+(?=\")"); // Ignore password in request body
    ignorePatterns.add("(?<=\"accessToken\":\")[^\"]+(?=\")"); // Ignore accessToken in request body
    ignorePatterns.add("(?<=\"refreshToken\":\")[^\"]+(?=\")"); // Ignore refreshToken in request body
  }

  public static String hideSensitiveData(String data) {
    data = data.replaceAll("\\\\n", "").replaceAll("\\\\r", "")
        .replaceAll("\\\\", "")
        .replaceAll("\\s*\"(\\w+)\"\\s*:\\s*\"(.*?)\"\\s*", "\"$1\":\"$2\""); // Xóa các ký tự thừa

    for (String pattern : ignorePatterns) {
      data = data.replaceAll(pattern, "*"); // Thay thế các pattern cần ẩn bằng dấu *
    }
    return data;
  }

  public static boolean isIgnoreUri(String uri) {
    return uri.contains("actuator") || uri.contains("swagger") || uri.contains("api-docs"); // Bỏ qua những request đến các uri này
  }

  public static void sendError(ContentCachingResponseWrapper responseWrapper, Status status) {
    try {
      responseWrapper.setStatus(status.getStatusCode());
      responseWrapper.setContentType("application/json; charset=UTF-8");
      GeneralResponse<Object> responseObject = new GeneralResponse<>();
      Status responseStatus = new Status(status.getApiPath(), status.getStatusCode(), status.getMessage(), status.getTimestamp());
      responseObject.setStatus(responseStatus);
      new ObjectMapper()
          .setAnnotationIntrospector(new JacksonAnnotationIntrospector())
          .registerModule(new JavaTimeModule())
          .setDateFormat(new StdDateFormat())
          .disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES)
          .setTimeZone(Calendar.getInstance().getTimeZone())
          .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
          .writeValue(responseWrapper.getWriter(), responseObject);
      responseWrapper.copyBodyToResponse();
    } catch (IOException e) {
      log.info("Error when send error response: {}", e.getMessage());
    }
  }
}
