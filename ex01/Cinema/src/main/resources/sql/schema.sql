-- =========================
-- DROP TABLES (optional)
-- =========================

DROP TABLE IF EXISTS user_authentication;
DROP TABLE IF EXISTS chat_messages;
DROP TABLE IF EXISTS avatars;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS halls;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS users;


-- =========================
-- USERS
-- =========================

CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255),
    password VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255)
);


-- =========================
-- FILMS
-- =========================

CREATE TABLE films (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    year VARCHAR(255),
    age_restrictions INT,
    description TEXT,
    poster_url VARCHAR(500)
);


-- =========================
-- HALLS
-- =========================

CREATE TABLE halls (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    serial_number BIGINT,
    seats_count INT
);


-- =========================
-- SESSIONS
-- =========================

CREATE TABLE sessions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    film_id BIGINT,
    hall_id BIGINT,

    date_time TIMESTAMP,
    ticket_price DOUBLE,

    CONSTRAINT fk_session_film
        FOREIGN KEY (film_id)
        REFERENCES films(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_session_hall
        FOREIGN KEY (hall_id)
        REFERENCES halls(id)
        ON DELETE CASCADE
);


-- =========================
-- AVATARS
-- =========================

CREATE TABLE avatars (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id VARCHAR(255),
    film_id BIGINT,

    file_name VARCHAR(255),
    original_file_name VARCHAR(255),
    url VARCHAR(500),

    uploaded_at TIMESTAMP,

    CONSTRAINT fk_avatar_film
        FOREIGN KEY (film_id)
        REFERENCES films(id)
        ON DELETE CASCADE
);


-- =========================
-- CHAT MESSAGES
-- =========================

CREATE TABLE chat_messages (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    film_id BIGINT,
    user_id VARCHAR(255),

    msg TEXT,

    date_time TIMESTAMP,

    CONSTRAINT fk_chat_film
        FOREIGN KEY (film_id)
        REFERENCES films(id)
        ON DELETE CASCADE
);


-- =========================
-- USER AUTHENTICATION
-- =========================

CREATE TABLE user_authentication (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id VARCHAR(255),

    ip_adress VARCHAR(255),

    date_time TIMESTAMP,

    film_id BIGINT,

    CONSTRAINT fk_auth_film
        FOREIGN KEY (film_id)
        REFERENCES films(id)
        ON DELETE CASCADE
);