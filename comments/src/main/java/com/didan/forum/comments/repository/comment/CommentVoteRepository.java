package com.didan.forum.comments.repository.comment;

import com.didan.forum.comments.constant.VoteType;
import com.didan.forum.comments.entity.comment.CommentVoteEntity;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentVoteRepository extends JpaRepository<CommentVoteEntity, Long> {
  Long countCommentVoteEntityByComment_IdAndVoteTypeIsLike(String commentId, VoteType voteType);
  List<CommentVoteEntity> findCommentVoteEntityByComment_IdAndVoteTypeIsLike(String commentId, VoteType voteType);
  Optional<CommentVoteEntity> findCommentVoteEntityByComment_IdAndUserId(String commentId, String userId);
}
