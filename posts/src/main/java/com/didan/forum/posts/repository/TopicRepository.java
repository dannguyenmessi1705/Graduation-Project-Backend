package com.didan.forum.posts.repository;

import com.didan.forum.posts.entity.TopicEntity;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface TopicRepository extends JpaRepository<TopicEntity, String> {
  Optional<TopicEntity> findTopicEntityByName(String name);

  @Query(value = "SELECT t FROM topics t LEFT JOIN t.posts p GROUP BY t.id ORDER BY COUNT(p) "
      + "DESC, COALESCE(MAX(p.updatedAt), MAX(p.createdAt)) DESC, t.name ASC")
  List<TopicEntity> findAllByOrderByPostCountDescUpdatedAtDescNameAsc();
}