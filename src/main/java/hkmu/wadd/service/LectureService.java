package hkmu.wadd.service;

import hkmu.wadd.dao.LectureRepository;
import hkmu.wadd.model.Lecture;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LectureService {

    @Autowired
    private LectureRepository lectureRepository;

    // Get all lectures
    public List<Lecture> getAllLectures() {
        return lectureRepository.findAll();
    }


    // Create or update a lecture
    public Lecture saveLecture(Lecture lecture) {
        return lectureRepository.save(lecture);
    }

    // Get a lecture by ID
    public Lecture getLectureById(Long id) {
        return lectureRepository.findById(id).orElse(null);
    }

    // Get all lectures for a specific course
    public List<Lecture> getLecturesByCourseId(Long courseId) {
        return lectureRepository.findByCourseId(courseId);
    }

    // Delete a lecture by ID
    public void deleteLecture(Long id) {
        lectureRepository.deleteById(id);
    }

    // Add a new note to a lecture
    public Lecture addNoteToLecture(Long lectureId, String noteUrl) {
        Lecture lecture = lectureRepository.findById(lectureId).orElseThrow(() ->
                new RuntimeException("Lecture not found with ID: " + lectureId)
        );

        // Add the note URL to the noteLinks list
        lecture.getNoteLinks().add(noteUrl);

        // Save the updated lecture
        return lectureRepository.save(lecture);
    }

    // Remove a note from a lecture
    public Lecture removeNoteFromLecture(Long lectureId, String noteUrl) {
        Lecture lecture = lectureRepository.findById(lectureId).orElseThrow(() ->
                new RuntimeException("Lecture not found with ID: " + lectureId)
        );

        // Remove the note URL from the noteLinks list
        lecture.getNoteLinks().remove(noteUrl);

        // Save the updated lecture
        return lectureRepository.save(lecture);
    }
}