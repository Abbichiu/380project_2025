package hkmu.wadd.dao;


import hkmu.wadd.model.UserRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface UserRoleRepository extends JpaRepository<UserRole, Integer> {
    // Find all roles for a specific user by username
    List<UserRole> findByUserUsername(String username);

    // Find all roles for a specific user by user ID
    List<UserRole> findByUserId(UUID user_id);

    // Find users with a specific role
    List<UserRole> findByRole(String role);
}


