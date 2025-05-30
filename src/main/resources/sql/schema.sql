-- 1. Delete Existing Tables (in reverse order of dependencies)
DROP TABLE IF EXISTS vote;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS poll_options;
DROP TABLE IF EXISTS poll;
DROP TABLE IF EXISTS lecture_notes;
DROP TABLE IF EXISTS lecture;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS users;

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
ALTER TABLE lecture ALTER COLUMN id RESTART WITH 4;

-- 4. Create the Lecture Notes table
CREATE TABLE IF NOT EXISTS lecture_notes (
                                             lecture_id BIGINT NOT NULL, -- Foreign key references numeric lecture ID
                                             note_url VARCHAR(255) NOT NULL,
                                             PRIMARY KEY (lecture_id, note_url),
                                             FOREIGN KEY (lecture_id) REFERENCES lecture(id) ON DELETE CASCADE
);

-- 5. Create the Users table
CREATE TABLE IF NOT EXISTS users (
                                     id UUID PRIMARY KEY,
                                     username VARCHAR(255) NOT NULL UNIQUE,
                                     email VARCHAR(255) NOT NULL UNIQUE,
                                     password VARCHAR(255) NOT NULL,
                                     full_name VARCHAR(255) NOT NULL, -- New column for full name
                                     phone_number VARCHAR(20) NOT NULL -- New column for phone number
);

-- 6. Create the User Roles table
CREATE TABLE IF NOT EXISTS user_roles (
                                          user_role_id INTEGER GENERATED ALWAYS AS IDENTITY,
                                          username VARCHAR(255) NOT NULL, -- Match length with "users.username"
                                          role VARCHAR(50) NOT NULL,
                                          PRIMARY KEY (user_role_id),
                                          FOREIGN KEY (username) REFERENCES users(username)
);

-- 7. Create the Poll table
CREATE TABLE IF NOT EXISTS poll (
                                    id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                    question VARCHAR(255) NOT NULL
);
ALTER TABLE poll ALTER COLUMN id RESTART WITH 3;
-- 8. Create the Poll Options table
CREATE TABLE IF NOT EXISTS poll_options (
                                            poll_id BIGINT NOT NULL,
                                            option_text VARCHAR(255) NOT NULL,
                                            PRIMARY KEY (poll_id, option_text),
                                            FOREIGN KEY (poll_id) REFERENCES poll(id) ON DELETE CASCADE
);


-- 9. Create the Comment table
CREATE TABLE IF NOT EXISTS comment (
                                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                       content TEXT NOT NULL,
                                       lecture_id BIGINT,
                                       poll_id BIGINT,
                                       user_id UUID NOT NULL,
                                       FOREIGN KEY (lecture_id) REFERENCES lecture(id) ON DELETE CASCADE,
                                       FOREIGN KEY (poll_id) REFERENCES poll(id) ON DELETE CASCADE,
                                       FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 10. Create the Vote table
-- 10. Create the Vote table
CREATE TABLE IF NOT EXISTS vote (
                                    id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                    poll_id BIGINT NOT NULL,
                                    user_id UUID NOT NULL,
                                    selected_option INT NOT NULL,
                                    voted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Add the voted_at column
                                    FOREIGN KEY (poll_id) REFERENCES poll(id) ON DELETE CASCADE,
                                    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
ALTER TABLE vote ALTER COLUMN id RESTART WITH 3;


