package hkmu.wadd.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
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

    // Custom handler for successful authentication
    @Bean
    public AuthenticationSuccessHandler authenticationSuccessHandler() {
        return (request, response, authentication) -> {
            System.out.println("Authentication success! User roles: " + authentication.getAuthorities());

            // Dynamically redirect to the context-aware index page
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/index");
        };
    }

    // NoOpPasswordEncoder to support plain-text passwords prefixed with `{noop}`
    @Bean
    public PasswordEncoder passwordEncoder() {
        return NoOpPasswordEncoder.getInstance();
    }

    // Security filter chain
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(authorize -> authorize
                        // Allow public access to /register (GET and POST)
                        .requestMatchers(HttpMethod.GET, "/register").permitAll()
                        .requestMatchers(HttpMethod.POST, "/register").permitAll()

                        // Restrict access to /teacher/** for TEACHER role
                        .requestMatchers("/teacher/**").hasRole("TEACHER")

                        // Allow access to /lecture/** for everyone
                        .requestMatchers("/lecture/**").authenticated()

                        // Require authentication for /poll/** endpoints
                        .requestMatchers("/poll/**").authenticated()



                        // Allow DELETE requests for /teacher/poll/** to TEACHER role
                        .requestMatchers(HttpMethod.DELETE, "/teacher/poll/**").hasRole("TEACHER")

                        // Allow all remaining requests
                        .anyRequest().permitAll()
                )
                // Custom login page and authentication success/failure handling
                .formLogin(form -> form
                        .loginPage("/login") // Custom login page
                        .defaultSuccessUrl("/index", true) // Redirect after successful login
                        .failureUrl("/login?error") // Redirect after failed login
                        .successHandler(authenticationSuccessHandler()) // Custom success handler
                        .permitAll() // Allow all users to access the login page
                )
                // Logout configuration
                .logout(logout -> logout
                        .logoutUrl("/logout") // Custom logout URL
                        .logoutSuccessUrl("/") // Redirect to homepage after logout
                        .invalidateHttpSession(true) // Invalidate session
                        .deleteCookies("JSESSIONID", "remember-me") // Delete cookies
                )
                // Remember-me functionality
                .rememberMe(remember -> remember
                        .key("uniqueAndSecret") // Key to secure remember-me tokens
                        .tokenValiditySeconds(86400) // 1-day token validity
                        .rememberMeParameter("remember-me") // Parameter name in the login form
                )
                // Enable HTTP Basic authentication (optional, for APIs)
                .httpBasic(withDefaults());

        // Return the built security filter chain
        return http.build();
    }
}