package hkmu.wadd.dao;


import hkmu.wadd.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface CommentRepository extends JpaRepository<Comment, Long> {
    List<Comment> findByLectureId(Long lectureId);
    // Fetch comments by user ID
    List<Comment> findByUserId(UUID userId);
}
