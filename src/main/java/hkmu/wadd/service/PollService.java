package hkmu.wadd.service;

import hkmu.wadd.dao.PollRepository;
import hkmu.wadd.model.Poll;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PollService {

    @Autowired
    private PollRepository pollRepository;

    // Create or update a poll
    public Poll savePoll(Poll poll) {
        return pollRepository.save(poll);
    }

    // Get a poll by ID
    public Poll getPollById(Long id) {
        return pollRepository.findById(id).orElse(null);
    }

    // Get a poll by its question
    public Poll getPollByQuestion(String question) {
        return pollRepository.findByQuestion(question);
    }

    // Get all polls
    public List<Poll> getAllPolls() {
        List<Poll> polls = pollRepository.findAll();

        // Initialize the "options" collection for each poll
        polls.forEach(poll -> poll.getOptions().size());

        return polls;
    }

    // Delete a poll by ID
    public void deletePoll(Long id) {
        pollRepository.deleteById(id);
    }

    // Add an option to a poll
    public Poll addOptionToPoll(Long pollId, String option) {
        Poll poll = pollRepository.findById(pollId).orElseThrow(() ->
                new RuntimeException("Poll not found with ID: " + pollId)
        );

        // Add the option to the options list
        poll.getOptions().add(option);

        // Save the updated poll
        return pollRepository.save(poll);
    }

    // Remove an option from a poll
    public Poll removeOptionFromPoll(Long pollId, String option) {
        Poll poll = pollRepository.findById(pollId).orElseThrow(() ->
                new RuntimeException("Poll not found with ID: " + pollId)
        );

        // Remove the option from the options list
        poll.getOptions().remove(option);

        // Save the updated poll
        return pollRepository.save(poll);
    }
}