package backend.vevent.server.Configure;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;

@Configuration
@Profile("qa")
public class QADatasourceConfig {


    @Value("${spring.datasource.qa.url}")
    private String qaURL;
    @Value("${spring.datasource.qa.username}")
    private String qaUser;
    @Value("${spring.datasource.qa.password}")
    private String qaPass;


    @Bean
    public DataSource dataSource(){
        DriverManagerDataSource dataSource = new DriverManagerDataSource();

        dataSource.setUrl(qaURL);
        dataSource.setUsername(qaUser);
        dataSource.setPassword(qaPass);

        return dataSource;
    }
}
