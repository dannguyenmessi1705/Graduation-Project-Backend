package com.didan.forum.users.function;

import com.didan.forum.users.dto.SendMailWithTemplate;
import com.didan.forum.users.service.impl.RedisServiceImpl;
import com.didan.forum.users.service.sendgrid.SendgridService;
import java.util.function.Consumer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@Slf4j
public class UserFunction {
  @Bean
  public Consumer<SendMailWithTemplate> listenUserRegister(SendgridService sendgridService, RedisServiceImpl redisService) {
    return sendMailWithTemplate -> {
      log.info("Sending email to {}", sendMailWithTemplate.getEmail());
      sendgridService.dispatchEmail(sendMailWithTemplate);
      String token = sendMailWithTemplate.getMessage().split("=")[1];
      redisService.setCache(
          "validate",
          token,
          token,
          600L
      );
    };
  }
}
