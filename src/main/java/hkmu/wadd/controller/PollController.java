package hkmu.wadd.controller;


import hkmu.wadd.model.Poll;
import hkmu.wadd.service.PollService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/poll")
public class PollController {

    @Autowired
    private PollService pollService;



    // Fetch poll details by ID
    @GetMapping("/{pollId}")
    public String getPollById(@PathVariable Long pollId, Model model) {
        Poll poll = pollService.getPollById(pollId);
        model.addAttribute("poll", poll);
        return "Poll-Details"; // Render poll-details.jsp
    }

    // Handle form submission
    @PostMapping("/vote")
    public String vote(@RequestParam Long pollId,
                       @RequestParam(required = false) List<String> selectedOptions,
                       Model model) {
        // Fetch the poll details
        Poll poll = pollService.getPollById(pollId);
        if (poll == null) {
            throw new RuntimeException("Poll not found");
        }

        // Calculate vote counts for each option
        List<Integer> voteCounts = new ArrayList<>();
        for (int i = 0; i < poll.getOptions().size(); i++) {
            int finalI = i + 1; // Options are 1-based
            long count = poll.getVotes().stream()
                    .filter(vote -> vote.getSelectedOption() == finalI)
                    .count();
            voteCounts.add((int) count);
        }

        // Add data to the model
        model.addAttribute("poll", poll);
        model.addAttribute("voteCounts", voteCounts);
        model.addAttribute("selectedOptions", selectedOptions != null ? selectedOptions : new ArrayList<>());

        return "Poll-Result"; // Render Poll-Result.jsp
    }
    @GetMapping("/poll/result")
    public String getPollResult(@RequestParam Long pollId, Model model) {
        // Fetch the poll details
        Poll poll = pollService.getPollById(pollId);
        if (poll == null) {
            throw new RuntimeException("Poll not found");
        }

        // Calculate vote counts for each option
        List<Integer> voteCounts = new ArrayList<>();
        for (int i = 0; i < poll.getOptions().size(); i++) {
            int finalI = i + 1; // Options are 1-based
            long count = poll.getVotes().stream()
                    .filter(vote -> vote.getSelectedOption() == finalI)
                    .count();
            voteCounts.add((int) count);
        }

        // Add data to the model
        model.addAttribute("poll", poll);
        model.addAttribute("voteCounts", voteCounts);

        return "Poll-Result"; // Render Poll-Result.jsp
    }
}
