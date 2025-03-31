package hkmu.wadd.service;

import hkmu.wadd.dao.CommentRepository;
import hkmu.wadd.model.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    public Comment createComment(Comment comment) {
        return commentRepository.save(comment);
    }

    public List<Comment> getCommentsByLectureId(Long lectureId) {
        return commentRepository.findByLectureId(lectureId);
    }

    public List<Comment> getCommentsByPollId(Long pollId) {
        return commentRepository.findByPollId(pollId);
    }

    public List<Comment> getCommentsByUserId(UUID userId) {
        return commentRepository.findByUserId(userId);
    }

    public void deleteComment(Long id) {
        commentRepository.deleteById(id);
    }
}
