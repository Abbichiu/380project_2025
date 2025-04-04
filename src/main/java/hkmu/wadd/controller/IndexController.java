package hkmu.wadd.controller;

import hkmu.wadd.model.Course;
import hkmu.wadd.model.Lecture;
import hkmu.wadd.model.Poll;
import hkmu.wadd.service.CommentService;
import hkmu.wadd.service.CourseService;
import hkmu.wadd.service.LectureService;
import hkmu.wadd.service.PollService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
    private CommentService commentService;

    // Accessible to everyone (including unauthenticated users)
    @GetMapping("/")
    @Transactional
    public String index(Model model) {
        // Fetch courses, lectures, and polls
        List<Course> courses = courseService.getAllCourses();
        List<Lecture> lectures = lectureService.getAllLectures();
        List<Poll> polls = pollService.getAllPolls();

        // Add data to the model
        model.addAttribute("courses", courses);
        model.addAttribute("lectures", lectures);
        model.addAttribute("polls", polls);

        // Return the JSP view name
        return "index"; // Resolves to /WEB-INF/jsp/index.jsp
    }

    // Accessible only to authenticated users
    @GetMapping("/index")
    @Transactional
    public String userIndex(Authentication authentication, Model model) {
        // Fetch user-specific data
        String username = authentication.getName();

        // Fetch courses, lectures, and polls
        List<Course> courses = courseService.getAllCourses();
        List<Lecture> lectures = lectureService.getAllLectures();
        List<Poll> polls = pollService.getAllPolls();

        // Add data to the model
        model.addAttribute("username", username);
        model.addAttribute("courses", courses);
        model.addAttribute("lectures", lectures);
        model.addAttribute("polls", polls);

        // Return the JSP view name
        return "user-index"; // Resolves to /WEB-INF/jsp/user-index.jsp
    }
    @GetMapping("/login")
    public String login() {

        return "login";
    }

}