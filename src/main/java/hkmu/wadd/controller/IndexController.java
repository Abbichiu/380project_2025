package hkmu.wadd.controller;

import hkmu.wadd.model.Comment;
import hkmu.wadd.model.Course;
import hkmu.wadd.model.Lecture;
import hkmu.wadd.model.Poll;
import hkmu.wadd.service.CommentService;
import hkmu.wadd.service.CourseService;
import hkmu.wadd.service.LectureService;
import hkmu.wadd.service.PollService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

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


    @GetMapping("/")
    @Transactional // Ensures the Hibernate session is active
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
    @GetMapping("/lecture/{lectureId}")
    @Transactional
    public String getLectureCourseMaterial(@PathVariable Long lectureId, Model model) {
        Lecture lecture = lectureService.getLectureById(lectureId);
        if (lecture == null) {
            throw new RuntimeException("Lecture not found with ID: " + lectureId);
        }
        System.out.println("Lecture: " + lecture);

        List<Comment> comments = commentService.getCommentsByLectureId(lectureId);
        System.out.println("Comments: " + comments);

        model.addAttribute("lecture", lecture);
        model.addAttribute("comments", comments);

        return "course-material";
    }
}