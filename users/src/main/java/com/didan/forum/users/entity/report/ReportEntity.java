package com.didan.forum.users.entity.report;

import com.didan.forum.users.constant.ReportType;
import com.didan.forum.users.entity.SuperClass;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "report")
@Table(
    indexes = {
        @Index(name = "idx_report_type", columnList = "report_type"),
        @Index(name = "idx_report_objectId", columnList = "object_id")
    },
    uniqueConstraints = {
        @UniqueConstraint(columnNames = {"report_type", "subject_report_id", "object_id"})
    }
)
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ReportEntity extends SuperClass implements Serializable {

  @Id
  @GeneratedValue(strategy = GenerationType.UUID)
  private String id;

  @Column(name = "report_type", nullable = false)
  @Enumerated(EnumType.STRING)
  private ReportType reportType;

  @Column(name = "subject_report_id", nullable = false)
  private String subjectReportId;

  @Column(name = "object_id", nullable = false)
  private String objectId;

  @Lob
  @Column(name = "report_content", nullable = true, length = 16777216)
  private String reportContent;
}
