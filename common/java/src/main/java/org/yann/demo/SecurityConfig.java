package org.yann.demo;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
// import org.yann.demo.repository.UserRepository;
// import org.springframework.security.core.userdetails.User;
// import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
// import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    // extends WebSecurityConfiguration{

    // private UserRepository userRepository;

    /**
     * @param http
     * @return
     * @throws Exception
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests((authorize) -> {

                    authorize
                            // .anyRequest().permitAll()
                            .requestMatchers("/hello").permitAll()
                            .requestMatchers("/h2-console/**").permitAll()
                            .anyRequest().authenticated();
                }
                )
                .httpBasic(Customizer.withDefaults())
                .formLogin(Customizer.withDefaults())
                .logout(logout -> logout
                        .invalidateHttpSession(true)
                        .deleteCookies("JESSIONID"));

        return http.build();
    }

    @Bean
    WebSecurityCustomizer webSecurityCustomizer() {
        return web -> web.ignoring()
                .requestMatchers(new AntPathRequestMatcher("/h2-console/**"));
    }

    @Bean
    public UserDetailsService userDetailsService() {
        UserDetails userDetails = User.builder()
                .username("user")
                .password(passwordEncoder().encode("password"))
                .roles("USER")
                .build();

        return new InMemoryUserDetailsManager(userDetails);
    }


    // @Bean
    // public AuthenticationManager authenticationManager(
    //         UserDetailsService userDetailsService,
    //         PasswordEncoder passwordEncoder) {
    //     DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
    //     authenticationProvider.setUserDetailsService(userDetailsService);
    //     authenticationProvider.setPasswordEncoder(passwordEncoder);

    //     return new ProviderManager(authenticationProvider);
    // }


    // @Bean
    // DataSource dataSource() {
    //     return new EmbeddedDatabaseBuilder()
    //             .setType(EmbeddedDatabaseType.H2)
    //             // .addScript(JdbcDaoImpl.DEFAULT_USER_SCHEMA_DDL_LOCATION)
    //             .build();
    // }
    

    // @Bean
    // public AuthenticationManager authenticationManager(
    //         UserDetailsService userDetailsService,
    //         PasswordEncoder passwordEncoder) throws Exception {
       
    //     DaoAuthenticationProvider authenticationProvider = new MyDaoAuthenticationProvider();
    //     authenticationProvider.setUserDetailsService(userDetailsService);
    //     authenticationProvider.setPasswordEncoder(passwordEncoder); // Inject password encoder if needed

    //     return new ProviderManager(authenticationProvider);
    // }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

}
