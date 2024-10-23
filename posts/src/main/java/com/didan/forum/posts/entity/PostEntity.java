package com.didan.forum.posts.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "posts")
@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter @ToString @Builder
public class PostEntity extends SuperClass {

  @Id
  @GeneratedValue(strategy = GenerationType.UUID)
  private String id;

  @Lob
  @Column(name = "title", nullable = false, length = 16777216)
  private String title;

  @Lob
  @Column(name = "content", nullable = false, length = 16777216)
  private String content;

  @Lob
  @Column(name = "files_attached", nullable = true, length = 16777216)
  private List<String> filesAttached;

  @Column(name = "author_id", nullable = false)
  private String authorId;
}
