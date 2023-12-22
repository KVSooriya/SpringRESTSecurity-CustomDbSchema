package com.vismee.springrestsecurityInMemory.securityconfigs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

import javax.sql.DataSource;

@Configuration
public class SecurityConfig
{
    // Spring security using custom table schema
    @Bean
    public UserDetailsManager userDetailsManager(DataSource datasource)
    {
        JdbcUserDetailsManager manager = new JdbcUserDetailsManager(datasource);
        manager.setUsersByUsernameQuery(
                "select user_id,pw,active from members where user_id=?"
        );
        manager.setAuthoritiesByUsernameQuery(
                "select user_id, role from roles where user_id=?"
        );

        return manager;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception
    {
        http.authorizeHttpRequests(configurer ->
                configurer.
                requestMatchers(HttpMethod.GET,"/api/employees").hasAnyRole("EMPLOYEE","MANAGER","ADMIN").
                requestMatchers(HttpMethod.GET,"/api/employees/**").hasAnyRole("EMPLOYEE","MANAGER","ADMIN").
                requestMatchers(HttpMethod.POST,"/api/employees").hasAnyRole("MANAGER","ADMIN").
                requestMatchers(HttpMethod.PUT,"/api/employees").hasAnyRole("MANAGER","ADMIN").
                requestMatchers(HttpMethod.DELETE,"/api/employees/**").hasRole("ADMIN")
        );

        http.httpBasic(Customizer.withDefaults());
        http.csrf(csrf -> csrf.disable());
        return http.build();
    }
}
