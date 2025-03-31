package hkmu.wadd.service;

import hkmu.wadd.dao.VoteRepository;
import hkmu.wadd.model.Vote;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class VoteService {

    @Autowired
    private VoteRepository voteRepository;

    public Vote createVote(Vote vote) {
        return voteRepository.save(vote);
    }

    public List<Vote> getVotesByUserId(UUID userId) {
        return voteRepository.findByUserId(userId);
    }

    public void deleteVote(Long id) {
        voteRepository.deleteById(id);
    }
}
