package com.didan.forum.users.repository;

import com.didan.forum.users.entity.ReportEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReportRepository extends JpaRepository<ReportEntity, String> {

}
