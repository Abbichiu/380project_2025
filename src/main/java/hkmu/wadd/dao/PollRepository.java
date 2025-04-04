package hkmu.wadd.dao;


import hkmu.wadd.model.Poll;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PollRepository extends JpaRepository<Poll, Long> {
    @Query("SELECT p FROM Poll p LEFT JOIN FETCH p.votes WHERE p.id = :pollId")
    Optional<Poll> findByIdWithVotes(@Param("pollId") Long pollId);
}