package com.didan.forum.posts.repository;

import com.didan.forum.posts.entity.PostEntity;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface PostRepository extends JpaRepository<PostEntity, String> {
  List<PostEntity> findPostEntityByAuthorIdOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(String authorId);
  List<PostEntity> findPostEntityByTopicIdOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(String topicId);
  List<PostEntity> findPostEntityByTopicIdOrderByUpdatedAtDescCreatedAtDesc(String topicId);
  List<PostEntity> findPostEntityByTitleContainingOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(String title);
  List<PostEntity> findPostEntityByContentContainingOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc(String content);

  @Transactional
  @Modifying
  @Query(value = "UPDATE posts p SET p.interactionScore = ?2 WHERE p.id = ?1")
  PostEntity updateByIdAndInteractionScore(String postId, Long interactionScore);

  @Query(value = "SELECT p FROM posts p ORDER BY p.interactionScore DESC, COALESCE(p.updatedAt, p"
      + ".createdAt) DESC, p.title ASC")
  List<PostEntity> findAllByOrderByInteractionScoreDescUpdatedAtDescCreatedAtDescTitleAsc();

  @Query(value = "SELECT p FROM posts p ORDER BY COALESCE(p.updatedAt, p.createdAt) DESC, p.title"
      + " ASC")
  List<PostEntity> findAllByOrderByUpdatedAtDescCreatedAtDescTitleAsc();

  Long countPostEntityByTopic_Id(String topicId);
}
