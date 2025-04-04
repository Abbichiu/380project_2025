package hkmu.wadd.service;

import hkmu.wadd.dao.LectureRepository;
import hkmu.wadd.model.Lecture;

import org.springframework.transaction.annotation.Transactional;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
    // Upload file and add its link to lecture materials
    @Transactional
    public void uploadLectureMaterial(Long lectureId, MultipartFile file) {
        try {
            // Fetch the lecture
            Lecture lecture = getLectureById(lectureId);
            if (lecture == null) {
                throw new RuntimeException("Lecture not found with ID: " + lectureId);
            }

            // Save the file to the local filesystem
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath); // Create the directory if it doesn't exist
            }

            String fileName = file.getOriginalFilename();
            Path filePath = uploadPath.resolve(fileName);
            Files.write(filePath, file.getBytes());

            // Generate the file URL (assuming the files are served from "/uploads/")
            String fileUrl = "/uploads/lecture-materials/" + fileName;

            // Add the file URL to the lecture's noteLinks
            List<String> noteLinks = lecture.getNoteLinks();
            noteLinks.add(fileUrl);
            lecture.setNoteLinks(noteLinks);

            // Save the updated lecture
            lectureRepository.save(lecture);
        } catch (Exception e) {
            throw new RuntimeException("Failed to upload file: " + e.getMessage(), e);
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