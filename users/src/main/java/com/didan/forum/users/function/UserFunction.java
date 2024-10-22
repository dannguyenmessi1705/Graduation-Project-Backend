package com.didan.forum.users.function;

import com.didan.forum.users.dto.SendMailWithTemplate;
import com.didan.forum.users.entity.TokenRequestEntity;
import com.didan.forum.users.repository.TokenRequestRepository;
import com.didan.forum.users.service.sendgrid.SendgridService;
import java.util.function.Consumer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@Slf4j
public class UserFunction {

  @Bean
  public Consumer<SendMailWithTemplate> listenUserEmail(SendgridService sendgridService,
      TokenRequestRepository tokenRequestRepository) {
    return sendMailWithTemplate -> {
      log.info("Sending email to {}", sendMailWithTemplate.getEmail());
      sendgridService.dispatchEmail(sendMailWithTemplate);
      String token = sendMailWithTemplate.getMessage().split("=")[1];
      TokenRequestEntity tokenRequest = TokenRequestEntity
          .builder()
          .userId(sendMailWithTemplate.getUserId())
          .id(token)
          .ttl(600L)
          .build();
      tokenRequestRepository.save(tokenRequest);
    };
  }
}
