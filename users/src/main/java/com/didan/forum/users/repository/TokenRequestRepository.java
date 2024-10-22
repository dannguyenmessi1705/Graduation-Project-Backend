package com.didan.forum.users.repository;

import com.didan.forum.users.entity.TokenRequestEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TokenRequestRepository extends CrudRepository<TokenRequestEntity, String> {
}
