package hkmu.wadd.dao;



import hkmu.wadd.model.User;
import hkmu.wadd.model.UserRole;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import jakarta.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class CustomUserService implements UserDetailsService {

    @Resource
    private UserRepository userRepository;

    @Override


    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        if (username == null || username.trim().isEmpty()) {
            throw new UsernameNotFoundException("Username cannot be null or empty");
        }

        User user = userRepository.findByUsername(username).orElse(null);

        if (user == null) {
            throw new UsernameNotFoundException("User '" + username + "' not found.");
        }

        // Convert user roles to GrantedAuthority objects
        List<GrantedAuthority> authorities = new ArrayList<>();
        if (user.getRoles() != null) {
            for (UserRole role : user.getRoles()) {
                authorities.add(new SimpleGrantedAuthority(role.getRole()));
            }
        }

        // Strip "{noop}" from the password before returning
        String password = user.getPassword();
        if (password.startsWith("{noop}")) {
            password = password.substring("{noop}".length());
        }

        // Return a Spring Security User object with username, password, and roles
        return new org.springframework.security.core.userdetails.User(user.getUsername(), password, authorities);
    }

    }

