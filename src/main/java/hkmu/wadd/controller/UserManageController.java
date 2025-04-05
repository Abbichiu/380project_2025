package hkmu.wadd.controller;

import hkmu.wadd.model.User;
import hkmu.wadd.service.UserService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.UUID;

@Controller
public class UserManageController {

    @Autowired
    private UserService userService;

    // Display the list of users (Accessible only to teachers)
    @Secured("ROLE_TEACHER")
    @GetMapping("/teacher/users")
    @Transactional
    public String listUsersForTeachers(Model model) {
        // Retrieve all users from the database
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "teacher-users"; // Resolves to /WEB-INF/jsp/teacher-users.jsp
    }

    // Update user information (Accessible only to teachers)
    @Secured("ROLE_TEACHER")
    @PostMapping("/teacher/users/update")
    public String updateUserByTeacher(
            @RequestParam UUID id,
            @RequestParam String fullName,
            @RequestParam String password,
            @RequestParam String email,
            @RequestParam String phoneNumber) {

        // Retrieve the user by ID
        User user = userService.getUserById(id);

        // Update the user's information
        user.setFullName(fullName);
        user.setPassword("{noop}" + password); // Add {noop} prefix to password
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);

        // Save the updated user back to the database
        userService.saveUser(user);

        // Redirect back to the user list
        return "redirect:/teacher/users";
    }

    // Delete user (Accessible only to teachers)
    @Secured("ROLE_TEACHER")
    @PostMapping("/teacher/users/delete")
    public String deleteUserByTeacher(@RequestParam UUID id) {
        // Delete the user by ID
        userService.deleteUserById(id);

        // Redirect back to the user list
        return "redirect:/teacher/users";
    }
}