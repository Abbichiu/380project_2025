package hkmu.wadd.controller;


import hkmu.wadd.model.Comment;
import hkmu.wadd.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/comments")
public class CommentController {

    @Autowired
    private CommentService commentService;

    // Fetch comments for the currently authenticated user
    @GetMapping("/history")
    public String getUserComments(Model model, Authentication authentication) {
        List<Comment> comments = commentService.getCommentsByUser(authentication); // Fetch user-specific comments
        model.addAttribute("comments", comments); // Add the comments to the model
        return "Comment-History"; // Render the comment-history.jsp page
    }
}