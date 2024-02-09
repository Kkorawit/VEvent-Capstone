package backend.vevent.server.Configure.Profiles;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;
import javax.xml.crypto.Data;

@Configuration
@Profile("prod")
public class ProdDatasourceConfig {

    @Value("${spring.datasource.prod.url}")
    private String prodURL;
    @Value("${spring.datasource.prod.username}")
    private String prodUser;
    @Value("${spring.datasource.prod.password}")
    private String prodPass;


    @Bean
    public DataSource dataSource(){
        DriverManagerDataSource dataSource = new DriverManagerDataSource();

        dataSource.setUrl(prodURL);
        dataSource.setUsername(prodUser);
        dataSource.setPassword(prodPass);

        return dataSource;
    }



}
