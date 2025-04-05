package hkmu.wadd.dao;



import hkmu.wadd.model.Vote;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface VoteRepository extends JpaRepository<Vote, Long> {

    // Find all votes by a user
    List<Vote> findByUserId(UUID userId);

    // Check if a user has voted in a specific poll
    boolean existsByPollIdAndUserId(Long pollId, UUID userId);

    // Check if a user has voted for a specific option in a specific poll
    boolean existsByPollIdAndUserIdAndSelectedOption(Long pollId, UUID userId, int selectedOption);
}