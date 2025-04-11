package hkmu.wadd.dao;


import hkmu.wadd.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends JpaRepository<User, UUID> {
    // Find user by username
    // Find user by username
    Optional<User> findByUsername(String username);
//
//    // Find user by email

    // Check if a username exists
    boolean existsByUsername(String username);

    // Check if an email exists
    boolean existsByEmail(String email);
    boolean existsByUsernameAndIdNot(String username, UUID id);



}
