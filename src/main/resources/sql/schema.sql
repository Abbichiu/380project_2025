-- 1. Delete Existing Tables (in reverse order of dependencies)
DROP TABLE IF EXISTS vote;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS poll_options;
DROP TABLE IF EXISTS poll;
DROP TABLE IF EXISTS lecture_notes;
DROP TABLE IF EXISTS lecture;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS "user";

-- 2. Create the Course table
CREATE TABLE IF NOT EXISTS course (
                                      id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                      name VARCHAR(255) NOT NULL
);

-- 3. Create the Lecture table
CREATE TABLE IF NOT EXISTS lecture (
                                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                       title VARCHAR(255) NOT NULL,
                                       description TEXT,
                                       course_id BIGINT NOT NULL,
                                       FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE
);

-- 4. Create the Lecture Notes table
CREATE TABLE IF NOT EXISTS lecture_notes (
                                             lecture_id BIGINT NOT NULL, -- Foreign key references numeric lecture ID
                                             note_url VARCHAR(255) NOT NULL,
                                             PRIMARY KEY (lecture_id, note_url),
                                             FOREIGN KEY (lecture_id) REFERENCES lecture(id) ON DELETE CASCADE
);

-- 5. Create the User table
CREATE TABLE IF NOT EXISTS "user" (
                                      id UUID PRIMARY KEY,
                                      username VARCHAR(255) NOT NULL UNIQUE,
                                      email VARCHAR(255) NOT NULL UNIQUE,
                                      password VARCHAR(255) NOT NULL,
                                      role VARCHAR(50) NOT NULL
);

-- 6. Create the Poll table
CREATE TABLE IF NOT EXISTS poll (
                                    id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                    question VARCHAR(255) NOT NULL
);

-- 7. Create the Poll Options table
CREATE TABLE IF NOT EXISTS poll_options (
                                            poll_id BIGINT NOT NULL,
                                            option_text VARCHAR(255) NOT NULL,
                                            PRIMARY KEY (poll_id, option_text),
                                            FOREIGN KEY (poll_id) REFERENCES poll(id) ON DELETE CASCADE
);

-- 8. Create the Comment table
CREATE TABLE IF NOT EXISTS comment (
                                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                       content TEXT NOT NULL,
                                       lecture_id BIGINT,
                                       poll_id BIGINT,
                                       user_id UUID NOT NULL,
                                       FOREIGN KEY (lecture_id) REFERENCES lecture(id) ON DELETE CASCADE,
                                       FOREIGN KEY (poll_id) REFERENCES poll(id) ON DELETE CASCADE,
                                       FOREIGN KEY (user_id) REFERENCES "user"(id) ON DELETE CASCADE
);

-- 9. Create the Vote table
CREATE TABLE IF NOT EXISTS vote (
                                    id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                    poll_id BIGINT NOT NULL,
                                    user_id UUID NOT NULL,
                                    selected_option INT NOT NULL,
                                    FOREIGN KEY (poll_id) REFERENCES poll(id) ON DELETE CASCADE,
                                    FOREIGN KEY (user_id) REFERENCES "user"(id) ON DELETE CASCADE
);