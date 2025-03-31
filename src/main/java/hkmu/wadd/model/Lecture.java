package hkmu.wadd.model;



import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;

import java.util.List;

@Entity
@Table(name = "lecture")
public class Lecture {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-incremented numeric ID
    private Long id; // Use Long as the primary key type

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "description")
    private String description;

    @ColumnDefault("0") // Default value for the course ID column
    @Column(name = "course_id", insertable = false, updatable = false)
    private Long courseId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id") // Defines the foreign key relationship
    private Course course;

    @ElementCollection
    @CollectionTable(name = "lecture_notes", joinColumns = @JoinColumn(name = "lecture_id"))
    @Column(name = "note_url")
    private List<String> noteLinks; // Stores the URLs for lecture notes

    @OneToMany(mappedBy = "lecture", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Comment> comments; // A list of comments related to this lecture

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

    public Long getCourseId() {
        return courseId;
    }

    public void setCourseId(Long courseId) {
        this.courseId = courseId;
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