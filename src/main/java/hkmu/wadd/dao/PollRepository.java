package hkmu.wadd.dao;



import hkmu.wadd.model.Poll;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PollRepository extends JpaRepository<Poll, Long> {
    // Custom query to find a poll by its question
    Poll findByQuestion(String question);
}