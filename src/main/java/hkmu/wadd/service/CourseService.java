package hkmu.wadd.service;

import hkmu.wadd.dao.CourseRepository;
import hkmu.wadd.model.Course;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseService {

    @Autowired
    private CourseRepository courseRepository;


    // Create a new course
    public Course createCourse(Course course) {
        return courseRepository.save(course);
    }



    // Get a course by ID
    public Course getCourseById(Long id) {
        return courseRepository.findById(id).orElse(null);
    }

    // Get all courses
    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }

    // Update an existing course
    public Course updateCourse(Long id, Course updatedCourse) {
        Course existingCourse = courseRepository.findById(id).orElseThrow(() ->
                new RuntimeException("Course not found with ID: " + id)
        );

        existingCourse.setName(updatedCourse.getName());
        return courseRepository.save(existingCourse);
    }

    // Delete a course by ID
    public void deleteCourse(Long id) {
        if (!courseRepository.existsById(id)) {
            throw new RuntimeException("Course not found with ID: " + id);
        }
        courseRepository.deleteById(id);
    }
}