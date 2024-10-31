package com.didan.forum.comments.repository.comment;

import com.didan.forum.comments.entity.comment.CommentEntity;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface CommentRepository extends JpaRepository<CommentEntity, String> {
  Optional<CommentEntity> findCommentEntityById(String id);

  @Query(value = "SELECT c FROM comments c WHERE c.postId = ?1 ORDER BY c.interactionScore DESC, COALESCE(c.updatedAt, c.createdAt) DESC, c.content ASC")
  Page<CommentEntity> findCommentByPostOrderInteraction(String postId, Pageable pageable);

  @Query(value = "SELECT c FROM comments c WHERE c.postId = ?1 ORDER BY COALESCE(c.updatedAt, c.createdAt) DESC, c.content ASC")
  Page<CommentEntity> findCommentByPostOrderTimeDesc(String postId, Pageable pageable);

  @Query(value = "SELECT c FROM comments c WHERE c.postId = ?1 ORDER BY COALESCE(c.updatedAt, c.createdAt) ASC, c.content ASC")
  Page<CommentEntity> findCommentByPostOrderTimeAsc(String postId, Pageable pageable);

  @Transactional
  @Modifying
  @Query(value = "UPDATE comments c SET c.interactionScore = c.interactionScore + ?2 WHERE c.id = ?1")
  void updateScoreComment(String commentId, Long score);

  @Transactional
  @Modifying
  @Query(value = "DELETE FROM comments c WHERE c.postId = ?1")
  void deleteCommentByPostId(String postId);

  Long countCommentEntitiesByPostId(String postId);

}
