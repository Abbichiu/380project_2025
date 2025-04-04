package hkmu.wadd.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public AuthenticationSuccessHandler authenticationSuccessHandler() {
        return (request, response, authentication) -> {
            System.out.println("Authentication success! User roles: " + authentication.getAuthorities());

            // Dynamically include the context path
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/index"); // Redirect to context-aware index page
        };
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        // Allows the use of plain text passwords with `{noop}`
        return NoOpPasswordEncoder.getInstance();
    }


    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(authorize -> authorize
                        // Restrict access to /teacher/** to users with ROLE_TEACHER
                        .requestMatchers("/teacher/**").hasRole("TEACHER")

                        // Allow access to /lecture/** to everyone (students and teachers)
                        .requestMatchers("/lecture/**").permitAll()

                        // Existing configurations for /user/** and /ticket/** URLs
                        .requestMatchers("/user/**").hasRole("ADMIN")
                        .requestMatchers("/ticket/delete/**").hasRole("ADMIN")
                        .requestMatchers("/ticket/**").hasAnyRole("USER", "ADMIN")

                        // Allow all other requests
                        .anyRequest().permitAll()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .defaultSuccessUrl("/index", true)
                        .failureUrl("/login?error")
                        .successHandler(authenticationSuccessHandler()) // Add success handler
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout") // Custom logout URL
                        .logoutSuccessUrl("/") // Redirect to homepage after logout
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID", "remember-me") // Delete cookies on logout
                )
                .rememberMe(remember -> remember
                        .key("uniqueAndSecret") // Key to secure the remember-me tokens
                        .tokenValiditySeconds(86400) // Validity period for the token (1 day)
                        .rememberMeParameter("remember-me") // The parameter name from the login form
                )
                .httpBasic(withDefaults());
        return http.build();
    }
}