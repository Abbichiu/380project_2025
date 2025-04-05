package hkmu.wadd.model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "poll")
public class Poll {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "question", nullable = false)
    private String question;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "poll_options", joinColumns = @JoinColumn(name = "poll_id"))
    @Column(name = "option_text")
    private List<String> options = new ArrayList<>(); // Initialize to prevent null pointer issues

    @OneToMany(mappedBy = "poll", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<Comment> comments = new ArrayList<>(); // Initialize to prevent null pointer issues

    @OneToMany(mappedBy = "poll", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<Vote> votes = new ArrayList<>(); // Initialize to prevent null pointer issues

    // Getters and setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public List<String> getOptions() {
        return options;
    }

    public void setOptions(List<String> options) {
        this.options = options;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments.clear(); // Clear the existing collection
        this.comments.addAll(comments); // Add the new comments
    }

    public List<Vote> getVotes() {
        return votes;
    }

    public void setVotes(List<Vote> votes) {
        this.votes = votes;
    }

    // Helper methods for managing the comments collection
    public void addComment(Comment comment) {
        comments.add(comment);
        comment.setPoll(this); // Maintain the relationship
    }

    public void removeComment(Comment comment) {
        comments.remove(comment);
        comment.setPoll(null); // Break the relationship
    }
}