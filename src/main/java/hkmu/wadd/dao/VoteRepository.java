package hkmu.wadd.dao;

import hkmu.wadd.model.Vote;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface VoteRepository extends JpaRepository<Vote, Long> {
    // Example custom query to find votes by user
    List<Vote> findByUserId(UUID userId);
}
