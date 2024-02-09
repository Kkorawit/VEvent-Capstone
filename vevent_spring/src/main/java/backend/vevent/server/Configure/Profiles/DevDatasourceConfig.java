package backend.vevent.server.Configure.Profiles;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;
import javax.xml.crypto.Data;

@Configuration
@Profile("dev")
public class DevDatasourceConfig {

    @Value("${spring.datasource.dev.url}")
    private String devURL;
    @Value("${spring.datasource.dev.username}")
    private String devUser;
    @Value("${spring.datasource.dev.password}")
    private String devPass;

    @Bean
    public DataSource dataSource(){
        DriverManagerDataSource dataSource = new DriverManagerDataSource();

        dataSource.setUrl(devURL);
        dataSource.setUsername(devUser);
        dataSource.setPassword(devPass);

        return dataSource;
    }

}
