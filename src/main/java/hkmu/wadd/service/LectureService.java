package hkmu.wadd.service;

import hkmu.wadd.dao.LectureRepository;
import hkmu.wadd.model.Lecture;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;



@Service
public class LectureService {

    // Inject the upload directory from application.properties or application.yml
    @Value("${lecture.materials.upload-dir}")
    private String uploadDirectory;

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
    // Upload multiple files and add their links to lecture materials
    public void uploadLectureMaterials(Long lectureId, MultipartFile[] files) {
        try {
            // Define the base upload directory
            Path uploadPath = Paths.get(System.getProperty("user.dir")).resolve(uploadDirectory);

            // Create the directory if it doesn't exist
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Fetch the lecture
            Lecture lecture = getLectureById(lectureId);
            if (lecture == null) {
                throw new RuntimeException("Lecture not found with ID: " + lectureId);
            }

            // Iterate through each file and process it
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    // Generate a unique filename for the uploaded file
                    String uniqueFilename = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                    Path filePath = uploadPath.resolve(uniqueFilename).normalize();

                    // Save the file to the resolved path
                    file.transferTo(filePath.toFile());

                    // Add the file's relative path to the lecture's noteLinks
                    lecture.getNoteLinks().add(uniqueFilename);
                }
            }

            // Save the updated lecture
            saveLecture(lecture);
        } catch (Exception e) {
            throw new RuntimeException("Error while uploading files: " + e.getMessage(), e);
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
            Path uploadPath = Paths.get(System.getProperty("user.dir")).resolve(uploadDirectory);
            Path filePath = uploadPath.resolve(fileUrl);
            Files.deleteIfExists(filePath);
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete file: " + e.getMessage(), e);
        }
    }
    public void save(Lecture lecture) {
        lectureRepository.save(lecture);
    }

    public void deleteById(Long id) {
        lectureRepository.deleteById(id);
    }
}