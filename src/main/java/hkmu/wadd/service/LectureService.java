package hkmu.wadd.service;

import hkmu.wadd.dao.LectureRepository;
import hkmu.wadd.model.Lecture;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Service
public class LectureService {

    private static final String UPLOAD_DIR = "uploads/lecture-materials"; // Directory to store uploaded files
    @Autowired
    private LectureRepository lectureRepository;

    // Get all lectures
    public List<Lecture> getAllLectures() {
        return lectureRepository.findAll();
    }


    // Get a lecture by ID
    public Lecture getLectureById(Long lectureId) {
        Lecture lecture = lectureRepository.findById(lectureId).orElse(null);
        if (lecture != null) {
            Hibernate.initialize(lecture.getNoteLinks()); // Manually initialize noteLinks
        }
        return lecture;
    }

    // Save the updated Lecture entity
    public void saveLecture(Lecture lecture) {
        lectureRepository.save(lecture);
    }
    // Upload file and add its link to lecture materials
    public void uploadLectureMaterial(Long lectureId, MultipartFile file) {
        try {
            // Define the base upload directory (relative to your project root)
            Path uploadDirectory = Paths.get(System.getProperty("user.dir")).resolve("uploads").resolve("lecture-materials");

            // Create the directory if it doesn't exist
            if (!Files.exists(uploadDirectory)) {
                Files.createDirectories(uploadDirectory); // Creates all necessary directories
            }

            // Resolve the file path within the upload directory
            Path filePath = uploadDirectory.resolve(file.getOriginalFilename()).normalize();

            // Save the file to the resolved path
            file.transferTo(filePath.toFile());

            // Update the lecture's noteLinks (e.g., save the relative path to the database)
            Lecture lecture = getLectureById(lectureId);
            lecture.getNoteLinks().add("lecture-materials/" + file.getOriginalFilename());
            saveLecture(lecture); // Save the lecture entity
        } catch (Exception e) {
            throw new RuntimeException("Error while uploading file: " + e.getMessage(), e);
        }
    }

    // Delete file and remove its link from lecture materials
    @Transactional
    public void deleteLectureMaterial(Long lectureId, String fileUrl) {
        try {
            // Fetch the lecture
            Lecture lecture = getLectureById(lectureId);
            if (lecture == null) {
                throw new RuntimeException("Lecture not found with ID: " + lectureId);
            }

            // Remove the file URL from the lecture's noteLinks
            List<String> noteLinks = lecture.getNoteLinks();
            if (!noteLinks.remove(fileUrl)) {
                throw new RuntimeException("File not found in lecture materials: " + fileUrl);
            }
            lecture.setNoteLinks(noteLinks);

            // Save the updated lecture
            lectureRepository.save(lecture);

            // Delete the file from the local filesystem
            Path filePath = Paths.get(UPLOAD_DIR).resolve(fileUrl.replace("/uploads/lecture-materials/", ""));
            Files.deleteIfExists(filePath);
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete file: " + e.getMessage(), e);
        }
    }

}