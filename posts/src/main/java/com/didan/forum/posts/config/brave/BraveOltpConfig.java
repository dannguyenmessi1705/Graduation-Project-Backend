package com.didan.forum.posts.config.brave;

import brave.handler.MutableSpan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import zipkin2.reporter.BytesEncoder;
import zipkin2.reporter.otel.brave.OtlpProtoV1Encoder;

@Configuration(proxyBeanMethods = false)
public class BraveOltpConfig {
  @Bean
  BytesEncoder<MutableSpan> oltpMutableSpanBytesEncoder() {
    return OtlpProtoV1Encoder.create();
  }
}
