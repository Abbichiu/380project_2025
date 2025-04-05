package hkmu.wadd.service;


import hkmu.wadd.dao.CommentRepository;
import hkmu.wadd.dao.PollRepository;
import hkmu.wadd.dao.UserRepository;
import hkmu.wadd.dao.VoteRepository;
import hkmu.wadd.model.Comment;
import hkmu.wadd.model.Poll;
import hkmu.wadd.model.User;
import hkmu.wadd.model.Vote;
import jakarta.transaction.Transactional;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
@Service
public class PollService {

    @Autowired
    private PollRepository pollRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private VoteRepository voteRepository;

    @Autowired
    private CommentRepository commentRepository;
    public List<Poll> getAllPolls() {
        List<Poll> polls = pollRepository.findAll();

        // Explicitly initialize the "options" collection for each poll
        polls.forEach(poll -> Hibernate.initialize(poll.getOptions()));

        return polls;
    }
    // Fetch a poll by ID (with votes and comments)
    @Transactional
    public Poll getPollByIdWithDetails(Long pollId) {
        Poll poll = pollRepository.findByIdWithVotes(pollId)
                .orElseThrow(() -> new RuntimeException("Poll not found for ID: " + pollId));

        // Explicitly initialize comments and options (if lazy-loaded)
        Hibernate.initialize(poll.getComments());
        Hibernate.initialize(poll.getOptions());

        return poll;
    }

    // Calculate vote counts for a poll
    public List<Integer> calculateVoteCounts(Poll poll) {
        List<Integer> voteCounts = new ArrayList<>(Collections.nCopies(poll.getOptions().size(), 0));

        for (Vote vote : poll.getVotes()) {
            int selectedOption = vote.getSelectedOption();

            // Skip invalid votes
            if (selectedOption < 0 || selectedOption >= poll.getOptions().size()) {
                continue;
            }

            voteCounts.set(selectedOption, voteCounts.get(selectedOption) + 1);
        }

        return voteCounts;
    }

    // Add a vote to a poll
    @Transactional
    public void addVote(Long pollId, int selectedOption, UUID userId) {
        Poll poll = getPollByIdWithDetails(pollId);

        // Validate the selected option index
        if (selectedOption < 0 || selectedOption >= poll.getOptions().size()) {
            throw new RuntimeException("Invalid option selected: " + selectedOption);
        }

        // Check if the user has already voted
        boolean alreadyVoted = voteRepository.findByUserId(userId).stream()
                .anyMatch(vote -> vote.getPoll().getId().equals(pollId) && vote.getSelectedOption() == selectedOption);

        if (alreadyVoted) {
            throw new RuntimeException("You have already voted for this option.");
        }

        // Save the vote
        Vote vote = new Vote();
        vote.setPoll(poll);
        vote.setUserId(userId);
        vote.setSelectedOption(selectedOption);
        vote.setVotedAt(LocalDateTime.now()); // Set the current timestamp for votedAt
        voteRepository.save(vote);
    }

    // Check if a user has already voted for a poll (optional utility method)
    public boolean hasUserVoted(Long pollId, UUID userId) {
        return voteRepository.findByUserId(userId).stream()
                .anyMatch(vote -> vote.getPoll().getId().equals(pollId));
    }

    // Add a comment to a poll
    @Transactional
    public void addComment(Long pollId, String username, String content) {
        Poll poll = getPollByIdWithDetails(pollId); // Unified method to fetch poll with all details
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found: " + username));

        Comment comment = new Comment();
        comment.setContent(content);
        comment.setUser(user);

        poll.addComment(comment); // Use helper method to add the comment
        pollRepository.save(poll); // Save the poll with the new comment
    }

    // Delete a comment by ID
    @Transactional
    public void deleteComment(Long commentId) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new RuntimeException("Comment not found"));

        Poll poll = comment.getPoll();
        poll.removeComment(comment); // Use helper method to remove the comment
        pollRepository.save(poll); // Save the poll with the comment removed
    }
    @Transactional
    public List<Vote> getVotingHistoryByUser(UUID userId) {
        // Fetch all votes by the user
        List<Vote> votes = voteRepository.findByUserId(userId);

        // Initialize poll details for each vote (if lazy-loaded)
        votes.forEach(vote -> Hibernate.initialize(vote.getPoll()));

        return votes;
    }
}
