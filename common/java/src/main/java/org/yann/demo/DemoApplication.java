package org.yann.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class DemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

	@GetMapping("/hello")
    public String hello(@RequestParam(value = "name", defaultValue = "World") String name) {
      return String.format("Hello %s!", name);
    }

	// @PostConstruct
    // private void initDb() {
	// 	System.out.println(String.format("****** Creating table: %s, and Inserting test data ******", "Employees"));

    //     String sqlStatements[] = {
	// 	"drop table employees if exists",
	// 	"create table employees(id serial,first_name varchar(255),last_name varchar(255))",
    //       "insert into employees(first_name, last_name) values('Donald','Trump')",
    //       "insert into employees(first_name, last_name) values('Barack','Obama')"
    //     };

    //     Arrays.asList(sqlStatements).forEach(sql -> {
    //         jdbcTemplate.execute(sql);
    //     });

    //     // Fetch data using SELECT statement and print results
    // } 

	// @Bean(initMethod = "start", destroyMethod = "stop")
    // public Server inMemoryH2DatabaseServer() throws SQLException {
    //     return Server.createTcpServer("-tcp", "-tcpAllowOthers", "-tcpPort", "9091");
    // }
}
