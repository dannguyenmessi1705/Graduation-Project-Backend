package com.didan.forum.comments.utils;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.introspect.JacksonAnnotationIntrospector;
import com.fasterxml.jackson.databind.util.StdDateFormat;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import java.util.Calendar;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;

@UtilityClass
@Slf4j
public class ObjectMapperUtils {
  public static final String EXCEPTION_WHEN_PARSING_JSON = "Exception when parsing [JSON=%s] to object [Class=%s";
  private static final ObjectMapper objectMapper;

  static {
    objectMapper = new ObjectMapper()
        .setAnnotationIntrospector(new JacksonAnnotationIntrospector())
        .registerModule(new JavaTimeModule())
        .setDateFormat(new StdDateFormat())
        .disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES)
        .setTimeZone(Calendar.getInstance().getTimeZone())
        .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
  }

  public static String toJson(Object obj) {
    try {
      return objectMapper.writeValueAsString(obj);
    } catch (Exception e) {
      log.error("Exception when parsing object to json", e);
      return null;
    }
  }

  public static String toJsonWithParamNotNullOrEmpty(Object obj) {
    try {
      ObjectMapper objectMapper1 = new ObjectMapper();
      objectMapper1.setSerializationInclusion(Include.NON_NULL);
      return objectMapper1.writeValueAsString(obj);
    } catch (Exception e) {
      log.error("Exception when parsing object to json", e);
      return null;
    }
  }

  public static <T> T fromJson(String json, TypeReference<T> typeReference) {
    try {
      return objectMapper.readValue(json, typeReference);
    } catch (Exception e) {
      log.error(String.format(EXCEPTION_WHEN_PARSING_JSON, json, typeReference.getType()), e);
      return null;
    }
  }

  public static <T> T fromJson(String json, Class<T> clazz) {
    try {
      return objectMapper.readValue(json, clazz);
    } catch (Exception e) {
      log.error(String.format(EXCEPTION_WHEN_PARSING_JSON, json, clazz.getName()), e);
      return null;
    }
  }

  public static <T> T fromJsonWithUnknownProperties(String json, TypeReference<T> typeReference) {
    try {
      ObjectMapper objectMapper1 = new ObjectMapper();
      objectMapper1.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
      return objectMapper1.readValue(json, typeReference);
    } catch (Exception e) {
      log.error(String.format(EXCEPTION_WHEN_PARSING_JSON, json, typeReference.getType()), e);
      return null;
    }
  }
}
