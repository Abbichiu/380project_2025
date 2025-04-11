package hkmu.wadd.model;


import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "lecture")
public class Lecture {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-incremented numeric ID
    private Long id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "description")
    private String description;

    // Remove @Column and rely on @JoinColumn
    @ManyToOne(fetch = FetchType.LAZY, optional = false) // Ensure the course is required
    @JoinColumn(name = "course_id", nullable = false) // Foreign key to Course
    private Course course;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "lecture_notes", joinColumns = @JoinColumn(name = "lecture_id"))
    @Column(name = "note_url")
    private List<String> noteLinks;

    @OneToMany(mappedBy = "lecture", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Comment> comments;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public List<String> getNoteLinks() {
        return noteLinks;
    }

    public void setNoteLinks(List<String> noteLinks) {
        this.noteLinks = noteLinks;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }
}