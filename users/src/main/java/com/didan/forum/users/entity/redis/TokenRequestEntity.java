package com.didan.forum.users.entity.redis;

import jakarta.persistence.Id;
import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.TimeToLive;

@NoArgsConstructor @AllArgsConstructor @Setter @Getter @ToString
@Builder
@RedisHash("USER:PASSWORD_REQUEST")
public class TokenRequestEntity implements Serializable {

  @Id
  private String id;

  @TimeToLive
  private Long ttl;

  private String userId;
}
