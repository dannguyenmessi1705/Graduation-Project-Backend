package com.didan.forum.comments.entity.comment;

import com.didan.forum.comments.entity.SuperClass;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.Lob;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "comments")
@Table(
    indexes = {
        @Index(name = "idx_author_id", columnList = "author_id"),
        @Index(name = "idx_post_id", columnList = "post_id"),
        @Index(name = "idx_interaction_score", columnList = "interaction_score"),
        @Index(name = "idx_reply_to_comment_id", columnList = "reply_to_comment_id")
    }
)
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class CommentEntity extends SuperClass {
  @Id
  @GeneratedValue(strategy = GenerationType.UUID)
  private String id;

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

  @Column(name = "post_id", nullable = false)
  private String postId;

  @Column(name = "reply_to_comment_id", nullable = true)
  private String replyToCommentId;

  @OneToMany(mappedBy = "comment", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
  private List<CommentVoteEntity> votes;
}
