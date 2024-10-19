package com.didan.forum.users.config.mail;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.validation.annotation.Validated;

@Validated
@Setter
@Getter
@ConfigurationProperties(prefix = "sendgrid")
public class SendgridConfigurationProperties {

  @NotBlank
  private String apiKey;

  @Email
  @NotBlank
  private String fromEmail;

  @NotBlank
  private String fromName;

  @NotBlank
  @Pattern(regexp = "^d-[a-f0-9]{32}$")
  private String templateId;

}
