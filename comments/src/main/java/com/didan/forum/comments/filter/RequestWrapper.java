package com.didan.forum.comments.filter;

import jakarta.servlet.ReadListener;
import jakarta.servlet.ServletInputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

@SuppressWarnings("all")
public class RequestWrapper extends HttpServletRequestWrapper {
  private final String body;

  public RequestWrapper(HttpServletRequest request) throws IOException {
    super(request);

    // Nếu request là multipart, không nên đọc trước body vì Spring cần xử lý phần này
    if (isMultipart(request)) {
      body = null; // Với multipart, không cần cache body
    } else {
      StringBuilder stringBuilder = new StringBuilder();
      try (InputStream inputStream = request.getInputStream();
          BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream))) {
        char[] charBuffer = new char[128];
        int bytesRead;
        while ((bytesRead = bufferedReader.read(charBuffer)) != -1) {
          stringBuilder.append(charBuffer, 0, bytesRead);
        }
      }
      body = stringBuilder.toString();
    }
  }

  private boolean isMultipart(HttpServletRequest request) {
    return request.getContentType() != null && request.getContentType().startsWith("multipart/");
  }

  @Override
  public ServletInputStream getInputStream() throws IOException {
    // Nếu là multipart, trả về InputStream gốc để Spring xử lý
    if (body == null) {
      return super.getInputStream();
    }

    final ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(body.getBytes());
    return new ServletInputStream() {
      @Override
      public boolean isFinished() {
        return byteArrayInputStream.available() == 0;
      }

      @Override
      public boolean isReady() {
        return true;
      }

      @Override
      public void setReadListener(ReadListener readListener) {
        // Không sử dụng trong trường hợp này
      }

      @Override
      public int read() throws IOException {
        return byteArrayInputStream.read();
      }
    };
  }

  @Override
  public BufferedReader getReader() throws IOException {
    if (body == null) {
      return super.getReader();
    }
    return new BufferedReader(new InputStreamReader(this.getInputStream()));
  }

  public String getBody() {
    return this.body;
  }
}