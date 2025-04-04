package hkmu.wadd.service;

import hkmu.wadd.dao.PollRepository;
import hkmu.wadd.dao.UserRepository;
import hkmu.wadd.dao.VoteRepository;
import hkmu.wadd.model.*;
import jakarta.transaction.Transactional;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    // Fetch a poll by ID
    @Transactional
    public Poll getPollById(Long pollId) {
        Poll poll = pollRepository.findByIdWithVotes(pollId)
                .orElseThrow(() -> new RuntimeException("Poll not found for ID: " + pollId));

        // Explicitly initialize the comments collection
        Hibernate.initialize(poll.getComments());

        return poll;
    }


    // Get all polls


    public List<Poll> getAllPolls() {
        List<Poll> polls = pollRepository.findAll();

        // Explicitly initialize the "options" collection for each poll
        polls.forEach(poll -> Hibernate.initialize(poll.getOptions()));

        return polls;
    }
    @Autowired
    private VoteRepository voteRepository;
    @Transactional
    public void addVote(Long pollId, int selectedOption, UUID userId) {
        Poll poll = getPollById(pollId);

        // Validate that the selected option index is within range
        if (selectedOption < 0 || selectedOption >= poll.getOptions().size()) {
            throw new RuntimeException("Invalid option selected: " + selectedOption);
        }

        // Check if the user has already voted for this poll and option
        boolean alreadyVoted = poll.getVotes().stream()
                .anyMatch(vote -> vote.getUserId().equals(userId) && vote.getSelectedOption() == selectedOption);

        if (alreadyVoted) {
            throw new RuntimeException("You have already voted for this option.");
        }

        // Create and save the vote
        Vote vote = new Vote();
        vote.setPoll(poll);
        vote.setUserId(userId);
        vote.setSelectedOption(selectedOption);

        voteRepository.save(vote);
    }

    public List<Integer> calculateVoteCounts(Poll poll) {
        List<Integer> voteCounts = new ArrayList<>(Collections.nCopies(poll.getOptions().size(), 0));

        for (Vote vote : poll.getVotes()) {
            int selectedOption = vote.getSelectedOption();

            // Skip votes with invalid selectedOption values
            if (selectedOption < 0 || selectedOption >= poll.getOptions().size()) {
                continue;
            }

            voteCounts.set(selectedOption, voteCounts.get(selectedOption) + 1);
        }

        return voteCounts;
    }

    @Transactional

    public void addComment(Long pollId, String username, String content) {
        // Fetch the poll by ID
        Poll poll = getPollById(pollId);
        if (poll != null) {
            // Fetch the user from the database
            User user = userRepository.findByUsername(username)
                    .orElseThrow(() -> new RuntimeException("User not found: " + username));

            // Create a new Comment
            Comment comment = new Comment();
            comment.setUser(user); // Associate the comment with the user
            comment.setContent(content); // Set the comment content
            comment.setPoll(poll); // Associate the comment with the poll

            // Add the comment to the poll and save
            poll.getComments().add(comment); // Add the comment to the poll's comments
            pollRepository.save(poll); // Save the updated poll
        }
    }


    }


