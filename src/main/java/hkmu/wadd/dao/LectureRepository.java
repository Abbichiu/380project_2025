package hkmu.wadd.dao;


import hkmu.wadd.model.Lecture;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LectureRepository extends JpaRepository<Lecture, Long> {
    // Custom query to find lectures by course ID
    List<Lecture> findByCourseId(Long courseId);
}