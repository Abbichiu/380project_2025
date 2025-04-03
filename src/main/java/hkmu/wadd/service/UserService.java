package hkmu.wadd.service;

import hkmu.wadd.dao.UserRepository;
import hkmu.wadd.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;
    // Create a new user
    public User createUser(User user) {
        return userRepository.save(user);
    }

    // Get a user by their ID
    public User getUserById(UUID id) {
        return userRepository.findById(id).orElse(null);
    }

    // Get a user by their username
    public User getUserByUsername(String username) {
        return userRepository.findByUsername(username).orElse(null);
    }

    // Get a user by their email
    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }

    // Check if a username already exists
    public boolean usernameExists(String username) {
        return userRepository.existsByUsername(username);
    }

    // Check if an email already exists
    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);
    }

    // Get all users with a specific role
    public List<User> getUsersByRole(String role) {
        return userRepository.findDistinctByRolesRole(role);
    }

    // Delete a user by their ID
    public void deleteUser(UUID id) {
        userRepository.deleteById(id);
    }
}