package com.didan.forum.posts.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "posts")
@Table(
    indexes = {
        @Index(name = "idx_author_id", columnList = "author_id"),
        @Index(name = "idx_title", columnList = "title"),
        @Index(name = "idx_content", columnList = "content")
    }
)
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

  @Column(name = "interaction_score", nullable = false)
  private Long interactionScore = 0L;

  @ManyToOne
  @JoinColumn(name = "topic_id", nullable = false)
  private TopicEntity topic;

  @OneToMany(mappedBy = "post")
  private List<PostVoteEntity> votes;
}
