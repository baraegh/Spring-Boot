-- =========================
-- USERS
-- =========================

INSERT INTO users (
    username,
    password,
    email,
    first_name,
    last_name,
    role,
    terms,
    created_at
)
VALUES
(
    'admin',
    '$2a$10$GrXU/Znpe3KxQC4425hDtu/bQCGeApNChGs39qj4X8/6RLoNNRnQC',
    'admin@cinema.com',
    'Admin',
    'User',
    'ADMIN',
    true,
    NOW()
),
(
    'john',
    '$2a$10$GrXU/Znpe3KxQC4425hDtu/bQCGeApNChGs39qj4X8/6RLoNNRnQC',
    'john@cinema.com',
    'John',
    'Doe',
    'USER',
    true,
    NOW()
),
(
    'jane',
    '$2a$10$GrXU/Znpe3KxQC4425hDtu/bQCGeApNChGs39qj4X8/6RLoNNRnQC',
    'jane@cinema.com',
    'Jane',
    'Smith',
    'USER',
    true,
    NOW()
)
ON CONFLICT (id) DO NOTHING;


-- =========================
-- FILMS
-- =========================

INSERT INTO films (title, year, age_restrictions, description, poster_url)
VALUES
('Inception', '2010', 13,
 'A thief who steals corporate secrets through dream-sharing technology.',
 'https://example.com/posters/inception.jpg'),

('Interstellar', '2014', 10,
 'Explorers travel through a wormhole searching for a new home for humanity.',
 'https://example.com/posters/interstellar.jpg'),

('The Dark Knight', '2008', 16,
 'Batman faces a criminal mastermind known as the Joker.',
 'https://example.com/posters/dark-knight.jpg')
 ON CONFLICT (id) DO NOTHING;


-- =========================
-- HALLS
-- =========================

INSERT INTO halls (serial_number, seats_count)
VALUES
(101, 50),
(102, 80),
(103, 120)
ON CONFLICT (id) DO NOTHING;


-- =========================
-- SESSIONS
-- =========================

INSERT INTO sessions 
(film_id, hall_id, date_time, ticket_price)
VALUES
(1, 1, '2026-06-18 18:30:00', 45.00),

(2, 2, '2026-06-18 21:00:00', 60.00),

(3, 3, '2026-06-19 20:00:00', 50.00)
ON CONFLICT (id) DO NOTHING;


-- =========================
-- AVATARS
-- =========================

INSERT INTO avatars
(user_id, film_id, file_name, original_file_name, url, uploaded_at)
VALUES
('1', 1,
 'avatar_001.jpg',
 'john_avatar.jpg',
 'https://example.com/uploads/avatar_001.jpg',
 '2026-06-18 10:15:00'),

('2', 2,
 'avatar_002.png',
 'jane_avatar.png',
 'https://example.com/uploads/avatar_002.png',
 '2026-06-18 11:20:00')
 ON CONFLICT (id) DO NOTHING;


-- =========================
-- CHAT MESSAGES
-- =========================

INSERT INTO chat_messages
(film_id, user_id, msg, date_time)
VALUES
(1, '1',
 'Amazing movie, the ending was crazy!',
 '2026-06-18 18:40:00'),

(1, '2',
 'The special effects are great.',
 '2026-06-18 18:45:00'),

(2, '3',
 'Interstellar is a masterpiece.',
 '2026-06-18 21:10:00')
 ON CONFLICT (id) DO NOTHING;


-- =========================
-- USER AUTHENTICATION
-- =========================

INSERT INTO user_authentication
(user_id, ip_adress, date_time, film_id)
VALUES
('1',
 '192.168.1.10',
 '2026-06-18 18:35:00',
 1),

('2',
 '192.168.1.11',
 '2026-06-18 18:50:00',
 1),

('3',
 '192.168.1.12',
 '2026-06-18 21:05:00',
 2)
 ON CONFLICT (id) DO NOTHING;