
package hkmu.wadd.service;

import hkmu.wadd.dao.UserRepository;
import hkmu.wadd.dao.UserRoleRepository;
import hkmu.wadd.model.User;
import hkmu.wadd.model.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserRoleRepository userRoleRepository;

    @Transactional

    public void saveUser(User user) {
        // Check if the username already exists for a different user
        if (userRepository.existsByUsernameAndIdNot(user.getUsername(), user.getId())) {
            throw new IllegalArgumentException("Username already exists: " + user.getUsername());
        }

        // Proceed to save the user
        userRepository.save(user);
    }
    @Transactional
    public void saveAdmin(User admin) {
        // Check if the username already exists
        if (userRepository.existsByUsername(admin.getUsername())) {
            throw new IllegalArgumentException("Username already exists: " + admin.getUsername());
        }

        // Save the admin user
        userRepository.save(admin);

        // Assign the "ROLE_ADMIN" role
        UserRole adminRole = new UserRole();
        adminRole.setUser(admin);
        adminRole.setRole("ROLE_ADMIN");
        userRoleRepository.save(adminRole);
    }

    @Transactional
    public void assignDefaultRole(User user) {
        // Ensure the user is already saved
        if (user.getId() == null) {
            throw new IllegalArgumentException("User must be saved before assigning roles.");
        }

        // Create a default role for the user
        UserRole defaultRole = new UserRole();
        defaultRole.setUser(user); // Set the saved user
        defaultRole.setRole("ROLE_STUDENT");

        // Save the user role
        userRoleRepository.save(defaultRole);

        // Add the role to the user's roles list
        user.getRoles().add(defaultRole);
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User getUserByUsername(String username) {
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new IllegalArgumentException("User not found with username: " + username));
    }

    public List<User> getAllAdmins() {
        // Use UserRoleRepository to fetch all "ROLE_ADMIN" entries
        List<UserRole> adminRoles = userRoleRepository.findByRole("ROLE_ADMIN");

        // Extract the users associated with the "ROLE_ADMIN" role
        return adminRoles.stream()
                .map(UserRole::getUser) // Get the User object from each UserRole
                .collect(Collectors.toList()); // Collect into a list
    }

    public User getUserById(UUID id) {
        return userRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("User not found"));
    }

    @Transactional

    public void deleteUserById(UUID id) {
        // Retrieve the user by ID
        User user = userRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        // Explicitly remove associated roles to avoid transient instance errors
        user.getRoles().clear();

        // Delete the user
        userRepository.delete(user);
    }
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

}