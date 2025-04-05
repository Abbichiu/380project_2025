package hkmu.wadd.controller;

import hkmu.wadd.dao.UserRepository;
import hkmu.wadd.model.Poll;
import hkmu.wadd.model.User;
import hkmu.wadd.model.Vote;
import hkmu.wadd.service.PollService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/poll")
public class PollController {

    @Autowired
    private PollService pollService;

    @Autowired
    private UserRepository userRepository;

    // Fetch poll details for a specific poll
    @GetMapping("/{pollId}")
    public String getPollDetails(@PathVariable Long pollId, Model model) {
        Poll poll = pollService.getPollByIdWithDetails(pollId); // Fetch poll with all details
        model.addAttribute("poll", poll);
        return "Poll-Details"; // Render Poll-Details.jsp
    }

    // Role-based endpoint to view poll results (student or teacher)
    private static final org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(PollController.class);

    // Role-based endpoint to view poll results (student or teacher)
    @GetMapping("/{pollId}/result")
    public String getRoleBasedPollResult(@PathVariable Long pollId, Authentication authentication, Model model) {
        Poll poll = pollService.getPollByIdWithDetails(pollId); // Fetch poll with all details
        model.addAttribute("poll", poll);
        model.addAttribute("voteCounts", pollService.calculateVoteCounts(poll));

        // Debugging: Log the user's roles
        List<String> roles = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());
        logger.debug("User [{}] has roles: {}", authentication.getName(), roles);

        // Check if the user is a teacher
        boolean isTeacher = roles.contains("ROLE_TEACHER");
        if (isTeacher) {
            logger.debug("User [{}] is a teacher, redirecting to teacher-Poll-Result.", authentication.getName());
            return "redirect:/poll/teacher/" + pollId + "/result"; // Redirect teachers to teacher-specific path
        }

        logger.debug("User [{}] is not a teacher, showing Poll-Result.", authentication.getName());
        return "Poll-Result"; // Render Poll-Result.jsp for students
    }

    // Teacher-specific poll results
    @GetMapping("/teacher/{pollId}/result")
    @Secured("ROLE_TEACHER")
    public String getTeacherPollResult(@PathVariable Long pollId, Model model, Authentication authentication) {
        Poll poll = pollService.getPollByIdWithDetails(pollId); // Fetch poll with all details
        model.addAttribute("poll", poll);
        model.addAttribute("voteCounts", pollService.calculateVoteCounts(poll));

        // Debugging: Log confirmation that the user is accessing the teacher view
        logger.debug("Teacher [{}] is accessing teacher-Poll-Result for poll ID [{}].", authentication.getName(), pollId);

        return "teacher-Poll-Result"; // Render teacher-specific results
    }

    // Handle voting
    @PostMapping("/vote")
    public String vote(@RequestParam Long pollId,
                       @RequestParam List<Integer> selectedOptions, // Accept multiple options
                       Authentication authentication,
                       Model model) {
        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found: " + username));
        UUID userId = user.getId();

        try {
            // Add votes for each selected option
            for (int selectedOption : selectedOptions) {
                pollService.addVote(pollId, selectedOption, userId);
            }
        } catch (RuntimeException e) {
            // Handle errors (e.g., duplicate voting or invalid options)
            Poll poll = pollService.getPollByIdWithDetails(pollId);
            model.addAttribute("poll", poll);
            model.addAttribute("voteCounts", pollService.calculateVoteCounts(poll));
            model.addAttribute("error", e.getMessage());
            return "Poll-Details"; // Render Poll-Details.jsp with error message
        }

        return "redirect:/poll/" + pollId + "/result"; // Redirect to poll results
    }

    // Add a comment to a poll (accessible to both students and teachers)
    @PostMapping("/{pollId}/comment")
    @Transactional
    public String addComment(@PathVariable Long pollId,
                             @RequestParam String content,
                             Authentication authentication) {
        String username = authentication.getName();
        pollService.addComment(pollId, username, content); // Add the comment
        return "redirect:/poll/" + pollId + "/result"; // Redirect to poll results
    }

    @DeleteMapping("/teacher/{pollId}/comment/{commentId}")
    @Secured("ROLE_TEACHER")
    @Transactional
    public String deleteComment(@PathVariable Long pollId, @PathVariable Long commentId) {
        System.out.println("Delete request received for pollId: " + pollId + ", commentId: " + commentId);
        pollService.deleteComment(commentId); // Delete the comment
        return "redirect:/poll/teacher/" + pollId + "/result"; // Redirect to teacher-specific poll results
    }

    @GetMapping("/history")
    public String getVotingHistory(Authentication authentication, Model model) {
        // Get the currently logged-in user's username
        String username = authentication.getName();

        // Retrieve the user by username
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found: " + username));

        // Fetch the user's voting history
        List<Vote> votingHistory = pollService.getVotingHistoryByUser(user.getId());

        // Add voting history to the model
        model.addAttribute("votingHistory", votingHistory);

        return "Poll-History"; // Render poll-history.jsp
    }

}