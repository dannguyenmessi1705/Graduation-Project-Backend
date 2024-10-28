package com.didan.forum.users.config.database;


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
    entityManagerFactoryRef = "reportsEntityManagerFactory",
    transactionManagerRef = "reportsTransactionManager",
    basePackages = {"com.didan.forum.users.repository.report"}
)
public class ReportDatabaseConfig {
  @Bean(name = "reportsDataSourceConfig")
  @ConfigurationProperties("spring.datasource.reportdb")
  public DataSourceProperties postsDataSourceProperties() {
    return new DataSourceProperties();
  }

  @Bean(name = "reportsDataSource")
  @ConfigurationProperties(prefix = "spring.datasource.reportdb.hiraki")
  public DataSource reportsDataSource() {
    return postsDataSourceProperties().initializeDataSourceBuilder().build();
  }

  @Bean(name = "reportsEntityManagerFactory")
  public LocalContainerEntityManagerFactoryBean reportsEntityManagerFactory(
      EntityManagerFactoryBuilder builder, @Qualifier("reportsDataSource") DataSource dataSource) {
    return builder
        .dataSource(dataSource)
        .packages("com.didan.forum.users.entity.report")
        .persistenceUnit("reports")
        .properties(hibernateProperties())
        .build();
  }

  @Primary
  @Bean(name = "reportsTransactionManager")
  public PlatformTransactionManager reportsTransactionManager(@Qualifier("reportsEntityManagerFactory")
  LocalContainerEntityManagerFactoryBean postsEntityManagerFactory) {
    return new JpaTransactionManager(Objects.requireNonNull(postsEntityManagerFactory.getObject()));
  }

  private Map<String, Object> hibernateProperties() {
    Map<String, Object> properties = new HashMap<>();
    properties.put("hibernate.hbm2ddl.auto", "update");
    properties.put("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
    return properties;
  }
}
