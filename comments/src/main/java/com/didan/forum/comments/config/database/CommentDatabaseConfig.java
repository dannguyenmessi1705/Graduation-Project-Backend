package com.didan.forum.comments.config.database;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import javax.sql.DataSource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.orm.jpa.EntityManagerFactoryBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Slf4j
@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(
    entityManagerFactoryRef = "commentsEntityManagerFactory",
    transactionManagerRef = "commentsTransactionManager",
    basePackages = {"com.didan.forum.comments.repository.comment"}
)
public class CommentDatabaseConfig {

  @Primary
  @Bean
  @ConfigurationProperties("spring.datasource.commentdb")
  public DataSourceProperties commentsDataSourceProperties() {
    return new DataSourceProperties();
  }

  @Primary
  @Bean(name = "commentsDataSource")
  @ConfigurationProperties(prefix = "spring.datasource.commentdb.hiraki")
  public DataSource commentsDataSource() {
    return commentsDataSourceProperties().initializeDataSourceBuilder().build();
  }

  @Primary
  @Bean(name = "commentsEntityManagerFactory")
  public LocalContainerEntityManagerFactoryBean postEntityManagerFactory(
    EntityManagerFactoryBuilder builder, @Qualifier("commentsDataSource") DataSource dataSource) {
    return builder
        .dataSource(dataSource)
        .packages("com.didan.forum.comments.entity.comment")
        .persistenceUnit("comments")
        .properties(hibernateProperties())
        .build();
  }

  @Primary
  @Bean(name = "commentsTransactionManager")
  public PlatformTransactionManager commentsTransactionManager(@Qualifier("commentsEntityManagerFactory")
      LocalContainerEntityManagerFactoryBean commentsEntityManagerFactory) {
    return new JpaTransactionManager(Objects.requireNonNull(commentsEntityManagerFactory.getObject()));
  }

  private Map<String, Object> hibernateProperties() {
    Map<String, Object> properties = new HashMap<>();
    properties.put("hibernate.hbm2ddl.auto", "update");
    properties.put("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
    return properties;
  }

}

