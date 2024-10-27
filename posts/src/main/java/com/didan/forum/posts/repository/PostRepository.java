package com.didan.forum.posts.repository;

import com.didan.forum.posts.entity.PostEntity;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface PostRepository extends JpaRepository<PostEntity, String> {
  Page<PostEntity> findPostEntityByAuthorIdOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(String authorId, Pageable pageable);
  Page<PostEntity> findPostEntityByTopicIdOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(String topicId, Pageable pageable);
  Page<PostEntity> findPostEntityByTopicIdOrderByUpdatedAtDescCreatedAtDesc(String topicId,
      Pageable pageable);
  Page<PostEntity> findPostEntityByTitleContainingOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(String title, Pageable pageable);
  Page<PostEntity> findPostEntityByContentContainingOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(String content, Pageable pageable);

  @Transactional
  @Modifying
  @Query(value = "UPDATE posts p SET p.interactionScore = p.interactionScore + ?2 WHERE p.id = ?1")
  PostEntity updateByIdAndInteractionScore(String postId, Long score);

  @Query(value = "SELECT p FROM posts p ORDER BY p.interactionScore DESC, COALESCE(p.updatedAt, p"
      + ".createdAt) DESC, p.title ASC")
  Page<PostEntity> findAllByOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(Pageable pageable);

  @Query(value = "SELECT p FROM posts p ORDER BY COALESCE(p.updatedAt, p.createdAt) DESC, p.title"
      + " ASC")
  Page<PostEntity> findAllByOrderByUpdatedAtDescCreatedAtDescTitleAsc(Pageable pageable);

  Long countPostEntityByTopic_Id(String topicId);
}
