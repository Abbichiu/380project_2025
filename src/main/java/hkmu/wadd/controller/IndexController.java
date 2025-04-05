package hkmu.wadd.controller;

import hkmu.wadd.model.Course;
import hkmu.wadd.model.Lecture;
import hkmu.wadd.model.Poll;
import hkmu.wadd.model.User;
import hkmu.wadd.service.CourseService;
import hkmu.wadd.service.LectureService;
import hkmu.wadd.service.PollService;
import hkmu.wadd.service.UserService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class IndexController {

    @Autowired
    private CourseService courseService;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private PollService pollService;

    @Autowired
    private UserService userService;

    // Accessible to everyone (including unauthenticated users)
    @GetMapping("/")
    @Transactional
    public String index(Model model) {
        List<Course> courses = courseService.getAllCourses();
        List<Lecture> lectures = lectureService.getAllLectures();
        List<Poll> polls = pollService.getAllPolls();

        model.addAttribute("courses", courses);
        model.addAttribute("lectures", lectures);
        model.addAttribute("polls", polls);

        return "index"; // Resolves to /WEB-INF/jsp/index.jsp
    }

    // Accessible only to authenticated users
    @GetMapping("/index")
    @Transactional
    public String userIndex(Authentication authentication, Model model) {
        // Get the currently logged-in user's username
        String username = authentication.getName();

        // Retrieve the user object by username
        User user = userService.getUserByUsername(username);

        // Retrieve all courses, lectures, and polls
        List<Course> courses = courseService.getAllCourses();
        List<Lecture> lectures = lectureService.getAllLectures();
        List<Poll> polls = pollService.getAllPolls();

        // Add attributes to the model
        model.addAttribute("username", user.getUsername());
        model.addAttribute("userId", user.getId()); // Pass the userId to the model
        model.addAttribute("courses", courses);
        model.addAttribute("lectures", lectures);
        model.addAttribute("polls", polls);

        // Return the user-index view
        return "user-index"; // Resolves to /WEB-INF/jsp/user-index.jsp
    }



    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        return "register"; // Resolves to /WEB-INF/jsp/register.jsp
    }

    @PostMapping("/register")
    public String handleRegister(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam String fullName,
            @RequestParam String email,
            @RequestParam String phoneNumber) {

        // Add the {noop} prefix to the password
        String prefixedPassword = "{noop}" + password;

        // Create a new User object
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(prefixedPassword); // Store password with {noop} prefix
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setPhoneNumber(phoneNumber);

        // Save the user to the database first
        userService.saveUser(newUser);

        // Assign default role to the saved user
        userService.assignDefaultRole(newUser);

        return "redirect:/login";
    }

    }