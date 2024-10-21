package com.didan.forum.users.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.Table;
import java.io.Serializable;

@Entity(name = "report")
@Table(
    indexes = {
        @Index(name = "idx_report_type", columnList = "type"),
        @Index(name = "idx_report_objectId", columnList = "objectId")
    }
)
public class ReportEntity extends SuperClass implements Serializable {

  @Id
  @GeneratedValue(strategy = GenerationType.UUID)
  private String id;

  @Column(nullable = false)
  private String type;

  @Column(nullable = false)
  private String objectId;

  @Column
  private Long count;
}
