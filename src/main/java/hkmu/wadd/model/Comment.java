package hkmu.wadd.model;

import jakarta.persistence.*;

@Entity
@Table(name = "comment")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @Column(name = "content", nullable = false)
    private String content;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "lecture_id", nullable = true)
    private Lecture lecture; // Comment on a lecture (optional)


    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "poll_id", nullable = true)
    private Poll poll; // Comment on a poll (optional)

    @ManyToOne(fetch = FetchType. EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user; // User who made the comment

    public String getRole() {
        // Assuming each user has one role, get the first role
        return user.getRoles().stream()
                .findFirst()
                .map(UserRole::getRole)
                .orElse("No Role");
    }

    // Getters and setters
    public Long getId() {
        return id;
    }



    public void setId(Long id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Lecture getLecture() {
        return lecture;
    }

    public void setLecture(Lecture lecture) {
        this.lecture = lecture;
    }

    public Poll getPoll() {
        return poll;
    }

    public void setPoll(Poll poll) {
        this.poll = poll;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}