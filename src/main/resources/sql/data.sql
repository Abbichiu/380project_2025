
-- Insert Users (with UUIDs)
INSERT INTO "USERS" (id, username, email, password, role) VALUES
                                                             ('11111111-1111-1111-1111-111111111111', 'student1', 'student1@example.com', 'password123', 'STUDENT'),
                                                             ('22222222-2222-2222-2222-222222222222', 'student2', 'student2@example.com', 'password123', 'STUDENT'),
                                                             ('33333333-3333-3333-3333-333333333333', 'teacher1', 'teacher1@example.com', 'password123', 'TEACHER'),
                                                             ('44444444-4444-4444-4444-444444444444', 'admin1', 'admin1@example.com', 'password123', 'ADMIN');

-- Insert Courses
DELETE FROM course WHERE id IN (1, 2);
INSERT INTO course (id, name) VALUES
                                  (1, 'Computer Science 101'),
                                  (2, 'Mathematics for Data Science');

-- Insert Lectures
INSERT INTO lecture (id, title, description, course_id) VALUES
                                                            (1, 'Introduction to Programming', 'Learn the basics of programming.', 1),
                                                            (2, 'Data Structures', 'Understand fundamental data structures.', 1),
                                                            (3, 'Linear Algebra Basics', 'Introduction to linear algebra concepts.', 2);

-- Insert Lecture Notes
INSERT INTO lecture_notes (lecture_id, note_url) VALUES
                                                     (1, 'https://example.com/notes1.pdf'),
                                                     (1, 'https://example.com/notes2.pdf'),
                                                     (2, 'https://example.com/notes3.pdf'),
                                                     (3, 'https://example.com/notes4.pdf');

-- Insert Polls
INSERT INTO poll (id, question) VALUES
    (1, 'Which date do you prefer for the mid-term test?');

-- Insert Poll Options
INSERT INTO poll_options (poll_id, option_text) VALUES
                                                    (1, 'March 1, 2025'),
                                                    (1, 'March 3, 2025'),
                                                    (1, 'March 5, 2025'),
                                                    (1, 'March 7, 2025');

-- Insert Votes
INSERT INTO vote (id, poll_id, user_id, selected_option) VALUES
                                                             (1, 1, '11111111-1111-1111-1111-111111111111', 2), -- Student 1 votes for Option 2
                                                             (2, 1, '22222222-2222-2222-2222-222222222222', 4); -- Student 2 votes for Option 4

-- Insert Comments on Lectures
INSERT INTO comment (id, content, lecture_id, poll_id, user_id) VALUES
                                                                    (1, 'This lecture was very informative!', 1, NULL, '11111111-1111-1111-1111-111111111111'), -- Student 1 comments on Lecture 1
                                                                    (2, 'I hope everyone has understood the basics.', 1, NULL, '33333333-3333-3333-3333-333333333333'), -- Teacher 1 comments on Lecture 1
                                                                    (3, 'Can you provide more examples of data structures?', 2, NULL, '22222222-2222-2222-2222-222222222222'); -- Student 2 comments on Lecture 2

-- Insert Comments on Polls
INSERT INTO comment (id, content, lecture_id, poll_id, user_id) VALUES
                                                                    (4, 'March 3 works best for me!', NULL, 1, '11111111-1111-1111-1111-111111111111'), -- Student 1 comments on Poll 1
                                                        (5, 'March 1 is the most suitable for the mid-term.', NULL, 1, '33333333-3333-3333-3333-333333333333');

