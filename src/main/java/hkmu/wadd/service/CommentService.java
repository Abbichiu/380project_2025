
package hkmu.wadd.service;

import hkmu.wadd.dao.CommentRepository;
import hkmu.wadd.dao.LectureRepository;
import hkmu.wadd.model.Comment;
import hkmu.wadd.model.Lecture;
import hkmu.wadd.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private LectureRepository lectureRepository;

    // Fetch all comments for a lecture
    public List<Comment> getCommentsByLectureId(Long lectureId) {
        return commentRepository.findByLectureId(lectureId);
    }

    // Add a new comment to a lecture
    @Transactional
    public void addComment(Long lectureId, String content, Authentication authentication) {
// Fetch the lecture
        Lecture lecture = lectureRepository.findById(lectureId)
                .orElseThrow(() -> new RuntimeException("Lecture not found with ID: " + lectureId));

        // Get the currently authenticated user
        User user = (User) authentication.getPrincipal(); // Assuming your User class is used for authentication

        // Create a new comment
        Comment comment = new Comment();
        comment.setContent(content);
        comment.setLecture(lecture);
        comment.setUser(user);

        // Save the comment
        commentRepository.save(comment);
    }

    // Delete a comment by its ID
    @Transactional
    public void deleteComment(Long commentId) {
        // Check if the comment exists
        if (!commentRepository.existsById(commentId)) {
            throw new RuntimeException("Comment not found with ID: " + commentId);
        }

        // Delete the comment
        commentRepository.deleteById(commentId);
    }
}
