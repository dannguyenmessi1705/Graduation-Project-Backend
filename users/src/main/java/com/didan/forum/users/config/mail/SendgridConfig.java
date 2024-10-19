package com.didan.forum.users.config.mail;

import com.sendgrid.SendGrid;
import com.sendgrid.helpers.mail.objects.Email;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@RequiredArgsConstructor
@EnableConfigurationProperties(SendgridConfigurationProperties.class)
public class SendgridConfig {
  private final SendgridConfigurationProperties props;

  @Bean
  public SendGrid sendGrid() {
    String apiKey = props.getApiKey();
    return new SendGrid(apiKey);
  }

  @Bean
  public Email fromEmail() {
    String fromEmail = props.getFromEmail();
    String fromName = props.getFromName();
    return new Email(fromEmail, fromName);
  }

  @Bean
  public String templateId() {
    return props.getTemplateId();
  }
}
