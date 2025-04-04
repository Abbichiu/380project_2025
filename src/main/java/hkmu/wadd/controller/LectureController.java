package hkmu.wadd.controller;

import hkmu.wadd.model.Comment;
import hkmu.wadd.model.Lecture;
import hkmu.wadd.service.CommentService;
import hkmu.wadd.service.LectureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller

public class LectureController {

    // Inject the upload directory from application.properties
    @Value("${lecture.materials.upload-dir}")
    private String uploadDirectory;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private CommentService commentService;

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

    @GetMapping("/lecture/{lectureId}/download")
    public ResponseEntity<?> downloadFile(@PathVariable Long lectureId, @RequestParam("fileUrl") String fileUrl) {
        try {
            // Check if the fileUrl is an external URL
            if (fileUrl.startsWith("http://") || fileUrl.startsWith("https://")) {
                // Redirect to the external URL
                return ResponseEntity.status(HttpStatus.FOUND)
                        .location(new URI(fileUrl))
                        .build();
            } else {
                // Handle local file download
                String decodedFileUrl = java.net.URLDecoder.decode(fileUrl, StandardCharsets.UTF_8);
                Path uploadDirectory = Paths.get(System.getProperty("user.dir"))
                        .resolve("uploads")
                        .resolve("lecture-materials");
                Path filePath = uploadDirectory.resolve(decodedFileUrl).normalize();

                if (!Files.exists(filePath) || !Files.isReadable(filePath)) {
                    return ResponseEntity.status(HttpStatus.NOT_FOUND)
                            .body("Error: File not found or not readable.");
                }

                Resource resource = new UrlResource(filePath.toUri());
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                        .body(resource);
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error: " + e.getMessage());
        }
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

    // Teacher version of lecture material page
    @GetMapping("/teacher/lecture/{lectureId}")
    @Secured("ROLE_TEACHER")
    @Transactional
    public String getTeacherLectureCourseMaterial(@PathVariable Long lectureId, Model model) {
        Lecture lecture = lectureService.getLectureById(lectureId);
        if (lecture == null) {
            throw new RuntimeException("Lecture not found with ID: " + lectureId);
        }

        List<Comment> comments = commentService.getCommentsByLectureId(lectureId);

        model.addAttribute("lecture", lecture);
        model.addAttribute("comments", comments);

        return "teacher-course-material"; // Resolves to /WEB-INF/jsp/teacher-course-material.jsp
    }

    // Upload file (Teacher only)
    @PostMapping("/teacher/lecture/{lectureId}/upload")
    @Secured("ROLE_TEACHER")
    @Transactional
    public String uploadFile(@PathVariable Long lectureId, @RequestParam("file") MultipartFile file) {
        lectureService.uploadLectureMaterial(lectureId, file);
        return "redirect:/teacher/lecture/" + lectureId; // Reload the page
    }

    @DeleteMapping("/teacher/lecture/{lectureId}/file")
    @Secured("ROLE_TEACHER")
    @Transactional
    public String deleteFile(@PathVariable Long lectureId, @RequestParam("fileUrl") String fileUrl) {
        lectureService.deleteLectureMaterial(lectureId, fileUrl);
        return "redirect:/teacher/lecture/" + lectureId; // Reload the page
    }

    // Delete comment (Teacher only)
    @DeleteMapping("/teacher/lecture/{lectureId}/comment/{commentId}")
    @Secured("ROLE_TEACHER")
    @Transactional
    public String deleteComment(@PathVariable Long lectureId, @PathVariable Long commentId) {
        commentService.deleteComment(commentId);
        return "redirect:/teacher/lecture/" + lectureId; // Reload the page
    }
}