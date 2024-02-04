package backend.vevent.server.Configure.Profiles;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;

@Configuration
@Profile("local")
public class LocalDatasourceConfig {

    @Value("${spring.datasource.url}")
    private String dURL;
    @Value("${spring.datasource.username}")
    private String dUser;
    @Value("${spring.datasource.password}")
    private String dPass;

    @Value("${server.servlet.context-path}")
    private String baseURL;
    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();

        dataSource.setUrl(dURL);
        dataSource.setUsername(dUser);
        dataSource.setPassword(dPass);

        return dataSource;
    }
}


