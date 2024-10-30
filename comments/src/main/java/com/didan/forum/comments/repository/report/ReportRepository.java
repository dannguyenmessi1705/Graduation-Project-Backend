package com.didan.forum.comments.repository.report;

import com.didan.forum.comments.entity.report.ReportEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReportRepository extends JpaRepository<ReportEntity, Long> {

}
