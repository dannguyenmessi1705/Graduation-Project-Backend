package com.didan.forum.notifications.config.database;

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
    entityManagerFactoryRef = "notificationsEntityManagerFactory",
    transactionManagerRef = "notificationsTransactionManager",
    basePackages = {"com.didan.forum.notifications.repository.notification"}
)
public class NotificationDatabaseConfig {

  @Primary
  @Bean
  @ConfigurationProperties("spring.datasource.notificationdb")
  public DataSourceProperties notificationsDataSourceProperties() {
    return new DataSourceProperties();
  }

  @Primary
  @Bean(name = "notificationsDataSource")
  @ConfigurationProperties(prefix = "spring.datasource.notificationdb.hiraki")
  public DataSource notificationsDataSource() {
    return notificationsDataSourceProperties().initializeDataSourceBuilder().build();
  }

  @Primary
  @Bean(name = "notificationsEntityManagerFactory")
  public LocalContainerEntityManagerFactoryBean notificationEntityManagerFactory(
      EntityManagerFactoryBuilder builder, @Qualifier("notificationsDataSource") DataSource dataSource) {
    return builder
        .dataSource(dataSource)
        .packages("com.didan.forum.notifications.entity.notification")
        .persistenceUnit("notifications")
        .properties(hibernateProperties())
        .build();
  }

  @Primary
  @Bean(name = "notificationsTransactionManager")
  public PlatformTransactionManager notificationsTransactionManager(@Qualifier("notificationsEntityManagerFactory")
  LocalContainerEntityManagerFactoryBean notificationsEntityManagerFactory) {
    return new JpaTransactionManager(Objects.requireNonNull(notificationsEntityManagerFactory.getObject()));
  }

  private Map<String, Object> hibernateProperties() {
    Map<String, Object> properties = new HashMap<>();
    properties.put("hibernate.hbm2ddl.auto", "update");
    properties.put("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
    return properties;
  }

}

