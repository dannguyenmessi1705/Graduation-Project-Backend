package com.didan.forum.comments.entity.comment;

import com.didan.forum.comments.constant.VoteType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity(name = "comment_votes")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class CommentVoteEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "user_id", nullable = false)
  private String userId;

  @ManyToOne
  @JoinColumn(name = "comment_id", nullable = false)
  private CommentEntity comment;

  @Column(name = "vote_type", nullable = false)
  @Enumerated(EnumType.STRING)
  private VoteType voteType;

}
