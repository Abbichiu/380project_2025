
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

@Service
    public class UserService {

        @Autowired
        private UserRepository userRepository;

        @Autowired
        private UserRoleRepository userRoleRepository;

        @Transactional
        public void saveUser(User user) {
            // Save the user first to generate a valid ID
            userRepository.save(user);
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

        public User getUserById(UUID id) {
            return userRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("User not found"));
        }
    @Transactional
    public void deleteUserById(UUID id) {
        userRepository.deleteById(id);
    }


        }
