package com.cinema.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.cinema.models.User.Role;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    private final String    REMEMBER_ME_KEY = "cinema-secret-key";
    private final String    REMEMBER_ME_PARM = "remember-me";
    private final int       VALIDATION_IN_SECONDS =  7 * 24 * 60 * 60;

    private final UserDetailsService userDetailsService;

    public SecurityConfig(UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/admin/**").hasRole(Role.ADMIN.name())
                .requestMatchers("/static/**", "/css/**").permitAll()
                .requestMatchers("/login", "/signUp").permitAll()
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .failureUrl("/login?error=true")
                .successHandler(authenticationSuccessHandler())
            ).logout(logout -> logout.logoutSuccessUrl("/login"))
            .rememberMe(remember -> remember
                .key(REMEMBER_ME_KEY)
                .rememberMeParameter(REMEMBER_ME_PARM)
                .tokenValiditySeconds(VALIDATION_IN_SECONDS)
                .userDetailsService(userDetailsService)
            );

        return http.build();
    }

    @Bean
    public AuthenticationSuccessHandler authenticationSuccessHandler() {
        return (request, response, authentication) -> {

            boolean isAdmin = authentication.getAuthorities()
                .stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

            if (isAdmin) {
                response.sendRedirect("/cinema/admin/panel/halls");
            } else {
                response.sendRedirect("/cinema/profile");
            }
        };
    }

    @Bean
    public PasswordEncoder encoder() {
        return new BCryptPasswordEncoder();
    }
}
