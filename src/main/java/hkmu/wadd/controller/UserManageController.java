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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
        // Retrieve all users and admins from the database
        List<User> users = userService.getAllUsers();
        List<User> admins = userService.getAllAdmins();
        model.addAttribute("users", users);
        model.addAttribute("admins", admins);
        return "teacher-users"; // Resolves to /WEB-INF/jsp/teacher-users.jsp
    }

    // Update user information (Accessible only to teachers)
    // Update user information (Accessible only to teachers)
    @Secured("ROLE_TEACHER")
    @PostMapping("/teacher/users/update")
    public String updateUserByTeacher(
            @RequestParam UUID id,
            @RequestParam String username,
            @RequestParam String fullName,
            @RequestParam String password,
            @RequestParam String email,
            @RequestParam String phoneNumber,
            RedirectAttributes redirectAttributes) {

        // Retrieve the user by ID
        User user = userService.getUserById(id);

        // Update the user's information
        user.setUsername(username);
        user.setFullName(fullName);
        user.setPassword("{noop}" + password); // Add {noop} prefix to password
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);

        // Save the updated user back to the database
        userService.saveUser(user);
// Add success message to flash attributes
        redirectAttributes.addFlashAttribute("successMessage", "User updated successfully!");

        // Redirect back to the user list
        return "redirect:/teacher/users";
    }

    // Delete user (Accessible only to teachers)
    @Secured("ROLE_TEACHER")
    @PostMapping("/teacher/users/delete")
    public String deleteUserByTeacher(@RequestParam UUID id,RedirectAttributes redirectAttributes) {
        // Delete the user by ID
        userService.deleteUserById(id);
// Add success message to flash attributes
        redirectAttributes.addFlashAttribute("successMessage", "User deleted successfully!");

        // Redirect back to the user list
        return "redirect:/teacher/users";
    }
    // Add an admin (Accessible only to teachers)
    @Secured("ROLE_TEACHER")
    @PostMapping("/teacher/users/add-admin")
    public String addAdmin(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam String fullName,
            @RequestParam String email,
            @RequestParam String phoneNumber) {

        User admin = new User();
        admin.setUsername(username);
        admin.setPassword("{noop}" + password); // Add {noop} prefix to password
        admin.setFullName(fullName);
        admin.setEmail(email);
        admin.setPhoneNumber(phoneNumber);

        // Save the admin with the role "ROLE_ADMIN"
        userService.saveAdmin(admin);


        // Redirect back to the user list
        return "redirect:/teacher/users";
    }

    // Update admin information (Accessible only to teachers)
    @Secured("ROLE_TEACHER")
    @PostMapping("/teacher/users/update-admin")
    public String updateAdmin(
            @RequestParam UUID id,
            @RequestParam String username,
            @RequestParam String fullName,
            @RequestParam String email,
            @RequestParam String phoneNumber,RedirectAttributes redirectAttributes) {

        // Retrieve the admin by ID
        User admin = userService.getUserById(id);

        // Update the admin's information
        admin.setUsername(username);
        admin.setFullName(fullName);
        admin.setEmail(email);
        admin.setPhoneNumber(phoneNumber);

        // Save the updated admin back to the database
        userService.saveUser(admin);
        // Add success message to flash attributes
        redirectAttributes.addFlashAttribute("successMessage", "Admin updated successfully!");
        // Redirect back to the user list
        return "redirect:/teacher/users";
    }

    // Delete an admin (Accessible only to teachers)
    @Secured("ROLE_TEACHER")
    @PostMapping("/teacher/users/delete-admin")
    public String deleteAdmin(@RequestParam UUID id,RedirectAttributes redirectAttributes) {
        userService.deleteUserById(id);
        // Add success message to flash attributes
        redirectAttributes.addFlashAttribute("successMessage", "Admin updated successfully!");
        return "redirect:/teacher/users";


    }
    @Secured({"ROLE_TEACHER", "ROLE_ADMIN", "ROLE_STUDENT"}) // Allow access to all roles
    @GetMapping("/profile")
    public String getProfile(@RequestParam UUID id, Model model) {
        // Retrieve the user by ID
        User user = userService.getUserById(id);

        // Add the user to the model
        model.addAttribute("user", user);

        // Return the profile view
        return "profile"; // Resolves to /WEB-INF/jsp/profile.jsp
    }

    @Secured({"ROLE_TEACHER", "ROLE_ADMIN", "ROLE_STUDENT"}) // Allow access to all roles
    @PostMapping("/profile/update")
    public String updateProfile(
            @RequestParam UUID id,
            @RequestParam String fullName,
            @RequestParam String password,
            @RequestParam String email,
            @RequestParam String phoneNumber,
            RedirectAttributes redirectAttributes) {

        // Retrieve the user by ID
        User user = userService.getUserById(id);

        // Update the user's information
        user.setFullName(fullName);
        user.setPassword("{noop}" + password); // Add {noop} prefix to password
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);

        // Save the updated user back to the database
        userService.saveUser(user);

        // Add success message
        redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully!");

        // Redirect back to the profile page
        return "redirect:/profile?id=" + id;
    }

}