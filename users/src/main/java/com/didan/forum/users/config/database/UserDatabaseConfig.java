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
    entityManagerFactoryRef = "usersEntityManagerFactory",
    transactionManagerRef = "usersTransactionManager",
    basePackages = {"com.didan.forum.users.repository.user"}
)
public class UserDatabaseConfig {

  @Primary
  @Bean
  @ConfigurationProperties("spring.datasource.userdb")
  public DataSourceProperties usersDataSourceProperties() {
    return new DataSourceProperties();
  }

  @Primary
  @Bean(name = "usersDataSource")
  @ConfigurationProperties(prefix = "spring.datasource.userdb.hiraki")
  public DataSource usersDataSource() {
    return usersDataSourceProperties().initializeDataSourceBuilder().build();
  }

  @Primary
  @Bean(name = "usersEntityManagerFactory")
  public LocalContainerEntityManagerFactoryBean userEntityManagerFactory(
    EntityManagerFactoryBuilder builder, @Qualifier("usersDataSource") DataSource dataSource) {
    return builder
        .dataSource(dataSource)
        .packages("com.didan.forum.users.entity.user")
        .persistenceUnit("users")
        .properties(hibernateProperties())
        .build();
  }

  @Primary
  @Bean(name = "usersTransactionManager")
  public PlatformTransactionManager usersTransactionManager(@Qualifier("usersEntityManagerFactory")
      LocalContainerEntityManagerFactoryBean usersEntityManagerFactory) {
    return new JpaTransactionManager(Objects.requireNonNull(usersEntityManagerFactory.getObject()));
  }

  private Map<String, Object> hibernateProperties() {
    Map<String, Object> properties = new HashMap<>();
    properties.put("hibernate.hbm2ddl.auto", "update");
    properties.put("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
    return properties;
  }

}
