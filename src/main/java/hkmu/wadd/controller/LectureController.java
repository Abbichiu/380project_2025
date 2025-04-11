package hkmu.wadd.controller;

import hkmu.wadd.model.Comment;
import hkmu.wadd.model.Course;
import hkmu.wadd.model.Lecture;
import hkmu.wadd.service.CommentService;
import hkmu.wadd.service.CourseService;
import hkmu.wadd.service.LectureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
public class LectureController {

    @Value("${lecture.materials.upload-dir}")
    private String uploadDirectory;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private CourseService courseService;

    // Fetch lecture for students
    @GetMapping("/lecture/{lectureId}")
    @Transactional
    public String getLectureCourseMaterial(@PathVariable Long lectureId, Model model) {
        Lecture lecture = lectureService.getLectureById(lectureId);
        if (lecture == null) {
            throw new RuntimeException("Lecture not found with ID: " + lectureId);
        }

        List<Comment> comments = commentService.getCommentsByLectureId(lectureId);

        model.addAttribute("lecture", lecture);
        model.addAttribute("comments", comments);

        return "course-material"; // Resolves to /WEB-INF/jsp/course-material.jsp
    }
    // Teacher version of lecture material page
    @GetMapping("/teacher/lecture/{lectureId}")
    @Secured("ROLE_TEACHER")
    @Transactional
    public String getTeacherLectureCourseMaterial(@PathVariable Long lectureId, Model model) {
        // Fetch the lecture by ID
        Lecture lecture = lectureService.getLectureById(lectureId);
        if (lecture == null) {
            throw new RuntimeException("Lecture not found with ID: " + lectureId);
        }

        // Fetch comments for the lecture
        List<Comment> comments = commentService.getCommentsByLectureId(lectureId);

        // Populate the model with lecture and comments
        model.addAttribute("lecture", lecture);
        model.addAttribute("comments", comments);

        // Return the teacher-specific JSP view
        return "teacher-course-material"; // Resolves to /WEB-INF/jsp/teacher-course-material.jsp
    }


    // Download file using the DownloadingView
    @GetMapping("/lecture/{lectureId}/download")
    public ResponseEntity<?> downloadFile(@PathVariable Long lectureId, @RequestParam("fileUrl") String fileUrl) {
        try {
            // Check if the fileUrl is an external URL
            if (fileUrl.startsWith("http://") || fileUrl.startsWith("https://")) {
                // Redirect to the external URL
                return ResponseEntity.status(HttpStatus.FOUND)
                        .location(new java.net.URI(fileUrl))
                        .build();
            }

            // Decode the file URL
            String decodedFileUrl = java.net.URLDecoder.decode(fileUrl, StandardCharsets.UTF_8);

            // Define the base upload directory
            Path uploadPath = Paths.get(System.getProperty("user.dir")).resolve(uploadDirectory);

            // Resolve the file path within the upload directory
            Path filePath = uploadPath.resolve(decodedFileUrl).normalize();

            // Log the resolved file path for debugging
            System.out.println("Resolved file path: " + filePath.toString());

            // Ensure the file exists and is readable
            if (!Files.exists(filePath) || !Files.isRegularFile(filePath) || !Files.isReadable(filePath)) {
                throw new RuntimeException("File not found or not readable: " + filePath.toString());
            }

            // Read the file contents into a byte array
            byte[] fileContents = Files.readAllBytes(filePath);

            // Create the HTTP response with the file contents
            return ResponseEntity.ok()
                    .header("Content-Disposition", "attachment; filename=\"" + filePath.getFileName().toString() + "\"")
                    .contentType(org.springframework.http.MediaType.APPLICATION_OCTET_STREAM)
                    .body(fileContents);
        } catch (Exception e) {
            throw new RuntimeException("Error while downloading file: " + e.getMessage(), e);
        }

    }

    // Upload file (Teacher only)
// Upload multiple files (Teacher only)
    @PostMapping("/teacher/lecture/{lectureId}/upload-multiple")
    @Secured("ROLE_TEACHER")
    @Transactional
    public String uploadFiles(@PathVariable Long lectureId, @RequestParam("files") MultipartFile[] files) {
        lectureService.uploadLectureMaterials(lectureId, files);
        return "redirect:/teacher/lecture/" + lectureId; // Reload the page
    }


    @DeleteMapping("/teacher/lecture/{lectureId}/file")
    @Secured("ROLE_TEACHER")
    @Transactional
    public String deleteFile(@PathVariable Long lectureId, @RequestParam("fileUrl") String fileUrl) {
        lectureService.deleteLectureMaterial(lectureId, fileUrl);
        return "redirect:/teacher/lecture/" + lectureId; // Reload the page
    }
    // Add a new comment (Student and Teacher)
    @PostMapping("/lecture/{lectureId}/comment")
    @Transactional
    public String addComment(@PathVariable Long lectureId, @RequestParam String content, Authentication authentication) {
        commentService.addComment(lectureId, content, authentication); // Save the comment
        return "redirect:/lecture/" + lectureId; // Redirect to the student's lecture page
    }

    //Add a new comment (Teacher only)
    @PostMapping("/teacher/lecture/{lectureId}/comment")
    @Secured("ROLE_TEACHER")
    @Transactional
    public String addTeacherComment(@PathVariable Long lectureId, @RequestParam String content, Authentication authentication) {
        System.out.println("User roles: " + authentication.getAuthorities());
        commentService.addComment(lectureId, content, authentication); // Save the comment
        return "redirect:/teacher/lecture/" + lectureId; // Redirect to the teacher's lecture page
    }
    // Handle role-based redirection after adding a comment
    @GetMapping("/lecture/{lectureId}/comment")
    public String redirectAfterComment(@PathVariable Long lectureId, Authentication authentication) {
        // Check if the user has the ROLE_TEACHER authority
        boolean isTeacher = authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_TEACHER"));
        if (isTeacher) {
            return "redirect:/teacher/lecture/" + lectureId;
        } else {
            return "redirect:/lecture/" + lectureId;
        }
    }
    // Delete comment (Teacher only)
    @DeleteMapping("/teacher/lecture/{lectureId}/comment/{commentId}")
    @Secured("ROLE_TEACHER")
    @Transactional
    public String deleteComment(@PathVariable Long lectureId, @PathVariable Long commentId) {
        commentService.deleteComment(commentId);
        return "redirect:/teacher/lecture/" + lectureId; // Reload the page
    }
    @Secured("ROLE_TEACHER")
    @PostMapping("/lecture/add")
    public String addLecture(@RequestParam String title, @RequestParam String description, Model model) {
        try {
            Course course = courseService.getCourseById(1L);
            if (course == null) {
                throw new RuntimeException("Course with ID 1 not found.");
            }

            Lecture lecture = new Lecture();
            lecture.setTitle(title);
            lecture.setDescription(description);
            lecture.setCourse(course);
            lectureService.save(lecture);

            return "redirect:/index";
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("error", "Failed to add lecture: Duplicate entry or database error.");
            return "error"; // Forward to an error page
        }
    }

    @Secured("ROLE_TEACHER")
    @PostMapping("/lecture/delete/{id}")
    public String deleteLecture(@PathVariable Long id) {
        lectureService.deleteById(id);
        return "redirect:/index";
    }

}