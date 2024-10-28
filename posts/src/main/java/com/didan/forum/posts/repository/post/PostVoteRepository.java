package com.didan.forum.posts.repository.post;

import com.didan.forum.posts.constant.VoteType;
import com.didan.forum.posts.entity.post.PostVoteEntity;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PostVoteRepository extends JpaRepository<PostVoteEntity, String> {
  Long countPostVoteEntityByPostIdAndVoteTypeIsLike(String postId, VoteType voteType);
  List<PostVoteEntity> findPostVoteEntityByPostIdAndVoteTypeIsLike(String postId, VoteType voteType);
  Optional<PostVoteEntity> findPostVoteEntityByPostIdAndUserId(String postId, String userId);
}
