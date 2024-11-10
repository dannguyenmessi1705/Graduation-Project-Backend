package com.didan.forum.posts.filter.cachehttp;

import jakarta.servlet.ReadListener;
import jakarta.servlet.ServletInputStream;
import jakarta.servlet.http.HttpServletRequest;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import org.springframework.util.StreamUtils;
import org.springframework.web.util.ContentCachingRequestWrapper;

@SuppressWarnings("all")
public class CachedBodyHttpServletRequest extends ContentCachingRequestWrapper {
  private byte[] cachedBody;

  public CachedBodyHttpServletRequest(HttpServletRequest request) throws IOException {
    super(request);
    // Kiểm tra nếu request là multipart thì không cache body
    if (isMultipart(request)) {
      this.cachedBody = null;
    } else {
      InputStream requestInputStream = request.getInputStream();
      this.cachedBody = StreamUtils.copyToByteArray(requestInputStream);
    }
  }

  private boolean isMultipart(HttpServletRequest request) {
    return request.getContentType() != null && request.getContentType().startsWith("multipart/");
  }

  public byte[] getCachedBody() {
    return this.cachedBody;
  }

  public void setCachedBody(byte[] cachedBody) {
    this.cachedBody = cachedBody;
  }

  public Map<String, String> getHeaders() {
    Map<String, String> map = new HashMap<>();
    Enumeration<String> headersName = this.getHeaderNames();

    while (headersName.hasMoreElements()) {
      String name = headersName.nextElement();
      map.put(name, this.getHeader(name));
    }

    return map;
  }

  @Override
  public ServletInputStream getInputStream() throws IOException {
    if (this.cachedBody == null) {
      return super.getInputStream();
    }

    return new ServletInputStream() {
      private final ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(cachedBody);

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
        // Not implemented
      }

      @Override
      public int read() throws IOException {
        return byteArrayInputStream.read();
      }
    };
  }
}
