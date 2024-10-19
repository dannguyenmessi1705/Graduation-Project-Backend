package com.didan.forum.users.service.sendgrid;

import com.didan.forum.users.dto.SendMailWithTemplate;
import com.didan.forum.users.exception.ErrorActionException;
import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.Response;
import com.sendgrid.SendGrid;
import com.sendgrid.helpers.mail.Mail;
import com.sendgrid.helpers.mail.objects.Attachments;
import com.sendgrid.helpers.mail.objects.Content;
import com.sendgrid.helpers.mail.objects.Email;
import com.sendgrid.helpers.mail.objects.Personalization;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
@Slf4j
@RequiredArgsConstructor
public class SendgridService {
  private final Email fromEmail;
  private final SendGrid sendGrid;
  private final String templateId;
  private static final String EMAIL_ENDPOINT = "mail/send";

  public void dispatchEmail(String receiverEmail, String subject, String body) {
    Email toEmail = new Email(receiverEmail);
    Content content = new Content("text/plain", body);
    Mail mail = new Mail(fromEmail, subject, toEmail, content);

    Request request = new Request();
    try {
      request.setMethod(Method.POST);
      request.setEndpoint(EMAIL_ENDPOINT);
      request.setBody(mail.build());

      Response response = sendGrid.api(request);
      log.info("Email sent to {} with status code {}", receiverEmail, response.getStatusCode());
    } catch (IOException ex) {
      log.error("Error while sending email: {}", ex.getMessage());
      throw new ErrorActionException("Error while sending email");
    }
  }

  public void dispatchEmail(String receiverEmail, String subject, String body, List<MultipartFile> files) {
    Email toEmail = new Email(receiverEmail);
    Content content = new Content("text/plain", body);
    Mail mail = new Mail(fromEmail, subject, toEmail, content);
    try {
      if (files != null && !files.isEmpty()) {
        for (MultipartFile file : files) {
          Attachments attachment = createAttachment(file);
          mail.addAttachments(attachment);
        }
      }
      Request request = new Request();
      request.setMethod(Method.POST);
      request.setEndpoint(EMAIL_ENDPOINT);
      request.setBody(mail.build());

      Response response = sendGrid.api(request);
      log.info("Email sent to {} with status code {}", receiverEmail, response.getStatusCode());
    } catch (IOException ex) {
      log.error("Error while sending email: {}", ex.getMessage());
      throw new ErrorActionException("Error while sending email");
    }
  }

  public void dispatchEmail(SendMailWithTemplate mailObject) {
    Email toEmail = new Email(mailObject.getEmail());
    DynamicTemplateData personalization = new DynamicTemplateData();
    personalization.add("email", mailObject.getEmail());
    personalization.add("firstName", mailObject.getFirstName());
    personalization.add("lastName", mailObject.getLastName());
    personalization.add("phoneNumber", mailObject.getPhoneNumber());
    personalization.add("message", mailObject.getMessage());

    Mail mail = new Mail();
    mail.setFrom(fromEmail);
    mail.setTemplateId(templateId);
    mail.addPersonalization(personalization);

    Request request = new Request();
    try {
      request.setMethod(Method.POST);
      request.setEndpoint(EMAIL_ENDPOINT);
      request.setBody(mail.build());

      Response response = sendGrid.api(request);
      log.info("Email sent to {} with status code {}", mailObject.getEmail(), response.getStatusCode());
    } catch (IOException ex) {
      log.error("Error while sending email: {}", ex.getMessage());
      throw new ErrorActionException("Error while sending email");
    }
  }

  private Attachments createAttachment(MultipartFile file) throws IOException {
    byte[] encodedFileContent = Base64.getEncoder().encode(file.getBytes());
    Attachments attachment = new Attachments();
    attachment.setDisposition("attachment");
    attachment.setType(file.getContentType());
    attachment.setFilename(file.getOriginalFilename());
    attachment.setContent(new String(encodedFileContent, StandardCharsets.UTF_8));
    return attachment;
  }

  class DynamicTemplateData extends Personalization {
    private final Map<String, Object> dynamicTemplateData = new HashMap<>();

    public void add(String key, String value) {
      dynamicTemplateData.put(key, value);
    }

    @Override
    public Map<String, Object> getDynamicTemplateData() {
      return dynamicTemplateData;
    }
  }
}
