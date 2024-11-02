package com.didan.forum.chats.config.database;

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
    entityManagerFactoryRef = "chatsEntityManagerFactory",
    transactionManagerRef = "chatsTransactionManager",
    basePackages = {"com.didan.forum.chats.repository.chat"}
)
public class ChatDatabaseConfig {

  @Primary
  @Bean
  @ConfigurationProperties("spring.datasource.chatdb")
  public DataSourceProperties chatsDataSourceProperties() {
    return new DataSourceProperties();
  }

  @Primary
  @Bean(name = "chatsDataSource")
  @ConfigurationProperties(prefix = "spring.datasource.chatdb.hiraki")
  public DataSource chatsDataSource() {
    return chatsDataSourceProperties().initializeDataSourceBuilder().build();
  }

  @Primary
  @Bean(name = "chatsEntityManagerFactory")
  public LocalContainerEntityManagerFactoryBean chatEntityManagerFactory(
      EntityManagerFactoryBuilder builder, @Qualifier("chatsDataSource") DataSource dataSource) {
    return builder
        .dataSource(dataSource)
        .packages("com.didan.forum.chats.entity.chat")
        .persistenceUnit("chats")
        .properties(hibernateProperties())
        .build();
  }

  @Primary
  @Bean(name = "chatsTransactionManager")
  public PlatformTransactionManager chatsTransactionManager(@Qualifier("chatsEntityManagerFactory")
  LocalContainerEntityManagerFactoryBean chatsEntityManagerFactory) {
    return new JpaTransactionManager(Objects.requireNonNull(chatsEntityManagerFactory.getObject()));
  }

  private Map<String, Object> hibernateProperties() {
    Map<String, Object> properties = new HashMap<>();
    properties.put("hibernate.hbm2ddl.auto", "update");
    properties.put("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
    return properties;
  }

}

