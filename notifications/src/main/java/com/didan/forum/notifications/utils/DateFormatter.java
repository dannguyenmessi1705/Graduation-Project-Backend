package com.didan.forum.notifications.utils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class DateFormatter {

  public static LocalDate format(String date) {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
    return LocalDate.parse(date, formatter);
  }
}

