-- Insert Users (with UUIDs)
-- Insert Users (with UUIDs)
INSERT INTO users (id, username, email, password, full_name, phone_number) VALUES
                                                                               ('11111111-1111-1111-1111-111111111111', 'keith', 'keith@example.com', '{noop}keithpw', 'Keith Chan', '1234567890'),
                                                                               ('22222222-2222-2222-2222-222222222222', 'mary', 'mary@example.com', '{noop}marypw', 'Mary Lee', '0987654321'),
                                                                               ('33333333-3333-3333-3333-333333333333', 'john', 'john@example.com', '{noop}johnpw', 'John Smith', '1122334455');

INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_ADMIN');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_TEACHER');
INSERT INTO user_roles(username, role) VALUES ('john', 'ROLE_TEACHER');
INSERT INTO user_roles(username, role) VALUES ('mary', 'ROLE_STUDENT');

-- Insert Courses
DELETE FROM course WHERE id IN (1, 2);
INSERT INTO course (id, name) VALUES
                                  (1, 'Computer Science 101');


-- Insert Lectures
INSERT INTO lecture (id, title, description, course_id) VALUES
                                                            (1, 'Introduction to Programming', 'Learn the basics of programming.', 1),
                                                            (2, 'Data Structures', 'Understand fundamental data structures.', 1),
                                                            (3, 'Linear Algebra Basics', 'Introduction to linear algebra concepts.', 1);

-- Insert Lecture Notes
INSERT INTO lecture_notes (lecture_id, note_url) VALUES
                                                     (1, 'https://example.com/notes1.pdf'),
                                                     (1, 'https://example.com/notes2.pdf'),
                                                     (2, 'https://example.com/notes3.pdf'),
                                                     (3, 'https://example.com/notes4.pdf');

-- Insert Polls
INSERT INTO poll (id, question) VALUES
                                    (1, 'Which date do you prefer for the mid-term test?'),
                                    (2, 'What is your favorite programming language?');

-- Insert Poll Options
INSERT INTO poll_options (poll_id, option_text) VALUES
                                                    (1, 'March 1, 2025'),
                                                    (1, 'March 3, 2025'),
                                                    (1, 'March 5, 2025'),
                                                    (1, 'March 7, 2025'),
                                                    (2, 'Java'),
                                                    (2, 'Python'),
                                                    (2, 'C++'),
                                                    (2, 'JavaScript');

-- Insert Votes
-- Insert Votes
INSERT INTO vote (id, poll_id, user_id, selected_option, voted_at) VALUES
                                                                       (1, 1, '11111111-1111-1111-1111-111111111111', 2, '2025-03-01 10:00:00'), -- Student 1 votes for Option 2
                                                                       (2, 1, '22222222-2222-2222-2222-222222222222', 4, '2025-03-01 11:00:00'); -- Student 2 votes for Option 4
-- Insert Comments on Lectures
INSERT INTO comment ( content, lecture_id, poll_id, user_id) VALUES
                                                                    ( 'This lecture was very informative!', 1, NULL, '11111111-1111-1111-1111-111111111111'), -- Student 1 comments on Lecture 1
                                                                    ( 'I hope everyone has understood the basics.', 1, NULL, '33333333-3333-3333-3333-333333333333'), -- Teacher 1 comments on Lecture 1
                                                                    ('Can you provide more examples of data structures?', 2, NULL, '22222222-2222-2222-2222-222222222222'); -- Student 2 comments on Lecture 2

-- Insert Comments on Polls
INSERT INTO comment (content, lecture_id, poll_id, user_id) VALUES
                                                                    ( 'March 3 works best for me!', NULL, 1, '11111111-1111-1111-1111-111111111111'), -- Student 1 comments on Poll 1

                                                              ( 'March 1 is the most suitable for the mid-term.', NULL, 1, '33333333-3333-3333-3333-333333333333');