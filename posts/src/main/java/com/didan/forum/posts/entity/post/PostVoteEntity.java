package com.didan.forum.posts.entity.post;

import com.didan.forum.posts.constant.VoteType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "post_votes")
@Table(
    uniqueConstraints = {
        @UniqueConstraint(columnNames = {"user_id", "post_id"})
    }
)
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
@Builder
public class PostVoteEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "user_id", nullable = false)
  private String userId;

  @ManyToOne
  @JoinColumn(name = "post_id", nullable = false)
  private PostEntity post;

  @Column(name = "vote_type", nullable = false)
  @Enumerated(EnumType.STRING)
  private VoteType voteType;

}
