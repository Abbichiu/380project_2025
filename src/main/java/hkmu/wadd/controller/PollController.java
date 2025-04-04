package hkmu.wadd.controller;

import hkmu.wadd.dao.UserRepository;
import hkmu.wadd.model.Poll;
import hkmu.wadd.model.User;
import hkmu.wadd.service.PollService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/poll")
public class PollController {

    @Autowired
    private PollService pollService;


    // Fetch poll details by ID
    @GetMapping("/{pollId}")
    public String showPollDetails(@PathVariable Long pollId, Model model) {
        Poll poll = pollService.getPollById(pollId); // Use the service layer to fetch the poll
        model.addAttribute("poll", poll);
        return "Poll-Details"; // Render the poll details view
    }
    @Autowired
    private UserRepository userRepository;
    @PostMapping("/vote")
    public String vote(@RequestParam Long pollId,
                       @RequestParam(required = false) List<Integer> selectedOptions,
                       Authentication authentication,
                       Model model) {
        Poll poll = pollService.getPollById(pollId);
        if (poll == null) {
            throw new RuntimeException("Poll not found");
        }

        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found: " + username));

        UUID userId = user.getId();

        try {
            if (selectedOptions != null) {
                selectedOptions.forEach(optionIndex -> pollService.addVote(pollId, optionIndex, userId));
            }
        } catch (RuntimeException e) {
            model.addAttribute("poll", poll);
            model.addAttribute("error", e.getMessage());
            return "Poll-Details";
        }

        return "redirect:/poll/result?pollId=" + pollId;
    }
    // Fetch poll results
    @GetMapping("/result")
    public String getPollResult(@RequestParam Long pollId, Model model) {
        Poll poll = pollService.getPollById(pollId);
        if (poll == null) {
            throw new RuntimeException("Poll not found");
        }

        List<Integer> voteCounts = pollService.calculateVoteCounts(poll);

        model.addAttribute("poll", poll);
        model.addAttribute("voteCounts", voteCounts);

        return "Poll-Result"; // Render Poll-Result.jsp
    }
    // Add a comment to a poll
    @PostMapping("/{pollId}/comment")
    public String addComment(@PathVariable Long pollId,
                             @RequestParam String content,
                             Authentication authentication,
                             Model model) {
        // Get the username of the currently authenticated user
        String username = authentication.getName();

        try {
            // Add the comment using the PollService
            pollService.addComment(pollId, username, content);
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/poll/" + pollId; // Redirect back to poll details page with error
        }

        // Redirect to the poll results page after adding the comment
        return "redirect:/poll/result?pollId=" + pollId;
    }

}


