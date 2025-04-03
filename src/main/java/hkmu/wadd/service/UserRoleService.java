package hkmu.wadd.service;


import hkmu.wadd.dao.UserRoleRepository;
import hkmu.wadd.model.UserRole;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserRoleService {

    private final UserRoleRepository userRoleRepository;

    // Constructor-based Dependency Injection
    public UserRoleService(UserRoleRepository userRoleRepository) {
        this.userRoleRepository = userRoleRepository;
    }

    /**
     * Fetch all roles for a specific user by username.
     *
     * @param username the username of the user
     * @return a list of roles associated with the user
     */
    public List<UserRole> getRolesByUsername(String username) {
        return userRoleRepository.findByUserUsername(username);
    }

    /**
     * Fetch all users who have a specific role.
     *
     * @param role the role to filter by
     * @return a list of UserRole objects with the specified role
     */
    public List<UserRole> getUsersWithRole(String role) {
        return userRoleRepository.findByRole(role);
    }

    /**
     * Save a new UserRole or update an existing one.
     *
     * @param userRole the UserRole object to save
     * @return the saved UserRole object
     */
    public UserRole saveUserRole(UserRole userRole) {
        return userRoleRepository.save(userRole);
    }

    /**
     * Delete a specific UserRole by its ID.
     *
     * @param id the ID of the UserRole to delete
     */
    public void deleteUserRoleById(int id) {
        userRoleRepository.deleteById(id);
    }
}
