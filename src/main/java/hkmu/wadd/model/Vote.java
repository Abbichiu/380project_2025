package hkmu.wadd.model;


import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "vote", uniqueConstraints = @UniqueConstraint(columnNames = {"poll_id", "user_id", "selected_option"}))
public class Vote {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "poll_id", nullable = false)
    private Poll poll; // Reference to the poll

    @Column(name = "user_id", nullable = false)
    private UUID userId; // UUID of the user who voted


    @Column(name = "selected_option", nullable = false)
    private int selectedOption; // Index of the selected option in the poll's options list the selected option (integer)


    @Column(name = "voted_at", nullable = false)
    private LocalDateTime votedAt; // Timestamp when the vote was cast


    public UUID getUserId() {
        return userId;
    }

    public int getSelectedOption() {
        return selectedOption;
    }

    public void setSelectedOption(int selectedOption) {
        this.selectedOption = selectedOption;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    // Getters and setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getVotedAt() {
        return votedAt;
    }

    public void setVotedAt(LocalDateTime votedAt) {
        this.votedAt = votedAt;
    }

    public Poll getPoll() {
        return poll;
    }

    public void setPoll(Poll poll) {
        this.poll = poll;
    }


}