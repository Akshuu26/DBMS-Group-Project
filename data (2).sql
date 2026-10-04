
-- NETFLIX DATABASE MANAGEMENT SYSTEM


-- Create Database
CREATE DATABASE NetflixDB;
USE NetflixDB;



CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(15)
);



CREATE TABLE SubscriptionPlans (
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    duration_months INT NOT NULL,
    max_devices INT NOT NULL
);



CREATE TABLE Subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    plan_id INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Active',

    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (plan_id) REFERENCES SubscriptionPlans(plan_id)
);


CREATE TABLE Profiles (
    profile_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    profile_name VARCHAR(50) NOT NULL,
    age_limit INT DEFAULT 18,

    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    release_year YEAR,
    duration_minutes INT,
    language VARCHAR(50),
    country VARCHAR(50)
);


CREATE TABLE TVShows (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    release_year YEAR,
    language VARCHAR(50),
    country VARCHAR(50)
);



CREATE TABLE Episodes (
    episode_id INT PRIMARY KEY AUTO_INCREMENT,
    show_id INT,
    season_number INT NOT NULL,
    episode_number INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    duration_minutes INT,

    FOREIGN KEY (show_id) REFERENCES TVShows(show_id)
);



CREATE TABLE Genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) UNIQUE NOT NULL
);



CREATE TABLE MovieGenres (
    movie_id INT,
    genre_id INT,

    PRIMARY KEY (movie_id, genre_id),

    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
);



CREATE TABLE ShowGenres (
    show_id INT,
    genre_id INT,

    PRIMARY KEY (show_id, genre_id),

    FOREIGN KEY (show_id) REFERENCES TVShows(show_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
);



CREATE TABLE WatchHistory (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    profile_id INT,
    movie_id INT NULL,
    episode_id INT NULL,
    watched_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    progress_minutes INT DEFAULT 0,

    FOREIGN KEY (profile_id) REFERENCES Profiles(profile_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (episode_id) REFERENCES Episodes(episode_id)
);



CREATE TABLE Ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    profile_id INT,
    movie_id INT NULL,
    show_id INT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),

    FOREIGN KEY (profile_id) REFERENCES Profiles(profile_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (show_id) REFERENCES TVShows(show_id)
);



CREATE TABLE Watchlist (
    watchlist_id INT PRIMARY KEY AUTO_INCREMENT,
    profile_id INT,
    movie_id INT NULL,
    show_id INT NULL,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (profile_id) REFERENCES Profiles(profile_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (show_id) REFERENCES TVShows(show_id)
);



-- INSERT DATA


INSERT INTO Users (name, email, password, phone)
VALUES
('Rahul Sharma', 'rahul@gmail.com', 'rahul123', '9876543210'),
('Aman Singh', 'aman@gmail.com', 'aman123', '9876543211'),
('Priya Verma', 'priya@gmail.com', 'priya123', '9876543212'),
('Rohan Gupta', 'rohan@gmail.com', 'rohan123', '9876543213');



INSERT INTO SubscriptionPlans
(plan_name, price, duration_months, max_devices)
VALUES
('Mobile', 149, 1, 1),
('Basic', 199, 1, 1),
('Standard', 499, 1, 2),
('Premium', 649, 1, 4);


INSERT INTO Subscriptions
(user_id, plan_id, start_date, end_date, status)
VALUES
(1, 4, '2026-09-01', '2026-10-01', 'Active'),
(2, 2, '2026-09-05', '2026-10-05', 'Active'),
(3, 3, '2026-08-15', '2026-09-15', 'Active'),
(4, 1, '2026-09-02', '2026-10-02', 'Active');

INSERT INTO Profiles
(user_id, profile_name, age_limit)
VALUES
(1, 'Rahul', 18),
(1, 'Kids', 12),
(2, 'Aman', 18),
(3, 'Priya', 18),
(4, 'Rohan', 18);


INSERT INTO Movies
(title, description, release_year, duration_minutes, language, country)
VALUES
('Inception',
 'A thief enters peoples dreams.',
 2010, 148, 'English', 'USA'),

('3 Idiots',
 'Three engineering students experience college life.',
 2009, 170, 'Hindi', 'India'),

('Interstellar',
 'A journey through space and time.',
 2014, 169, 'English', 'USA'),

('Dangal',
 'A father trains his daughters to become wrestlers.',
 2016, 161, 'Hindi', 'India'),

('The Dark Knight',
 'Batman faces a dangerous criminal mastermind.',
 2008, 152, 'English', 'USA');


INSERT INTO TVShows
(title, description, release_year, language, country)
VALUES
('Stranger Things',
 'A group of friends face supernatural events.',
 2016, 'English', 'USA'),

('Money Heist',
 'A group attempts a major robbery.',
 2017, 'Spanish', 'Spain'),

('Wednesday',
 'A student investigates mysterious events.',
 2022, 'English', 'USA');



INSERT INTO Episodes
(show_id, season_number, episode_number, title, duration_minutes)
VALUES
(1, 1, 1, 'The Vanishing of Will Byers', 50),
(1, 1, 2, 'The Weirdo on Maple Street', 56),
(1, 1, 3, 'Holly Jolly', 51),

(2, 1, 1, 'Episode 1', 48),
(2, 1, 2, 'Episode 2', 42),

(3, 1, 1, 'Wednesday Child Is Full of Woe', 50),
(3, 1, 2, 'Woe What a Night', 48);




INSERT INTO Genres (genre_name)
VALUES
('Action'),
('Comedy'),
('Drama'),
('Sci-Fi'),
('Thriller'),
('Horror'),
('Romance');




INSERT INTO MovieGenres (movie_id, genre_id)
VALUES
(1, 4), -- Inception - Sci-Fi
(1, 5), -- Inception - Thriller

(2, 2), -- 3 Idiots - Comedy
(2, 3), -- 3 Idiots - Drama

(3, 4), -- Interstellar - Sci-Fi
(3, 3), -- Interstellar - Drama

(4, 3), -- Dangal - Drama
(4, 1), -- Dangal - Action

(5, 1), -- Dark Knight - Action
(5, 5); -- Dark Knight - Thriller



INSERT INTO ShowGenres (show_id, genre_id)
VALUES
(1, 4), -- Stranger Things - Sci-Fi
(1, 6), -- Stranger Things - Horror
(1, 5), -- Stranger Things - Thriller

(2, 5), -- Money Heist - Thriller
(2, 3), -- Money Heist - Drama

(3, 6), -- Wednesday - Horror
(3, 5); -- Wednesday - Thriller




INSERT INTO WatchHistory
(profile_id, movie_id, episode_id, progress_minutes)
VALUES
(1, 1, NULL, 120),
(1, 3, NULL, 169),
(2, 2, NULL, 80),
(3, NULL, 1, 35),
(3, NULL, 2, 40),
(4, 5, NULL, 100),
(5, NULL, 6, 30);



INSERT INTO Ratings
(profile_id, movie_id, show_id, rating)
VALUES
(1, 1, NULL, 5),
(1, 3, NULL, 5),
(2, 2, NULL, 4),
(3, NULL, 1, 5),
(4, 5, NULL, 5),
(5, NULL, 3, 4);



INSERT INTO Watchlist
(profile_id, movie_id, show_id)
VALUES
(1, 4, NULL),
(1, NULL, 1),
(2, 2, NULL),
(3, 5, NULL),
(4, NULL, 2),
(5, NULL, 3);



-- DISPLAY DATA


SELECT * FROM Users;

SELECT * FROM SubscriptionPlans;

SELECT * FROM Subscriptions;

SELECT * FROM Profiles;

SELECT * FROM Movies;

SELECT * FROM TVShows;

SELECT * FROM Episodes;

SELECT * FROM Genres;

SELECT * FROM MovieGenres;

SELECT * FROM ShowGenres;

SELECT * FROM WatchHistory;

SELECT * FROM Ratings;

SELECT * FROM Watchlist;


--Basic SELECT statements


-- 1. Display all movies
SELECT * FROM Movies;

-- 2. Display only movie titles and release years
SELECT title, release_year
FROM Movies;

-- 3. Display distinct languages available
SELECT DISTINCT language
FROM Movies;

-- 4. Display movies released after 2020
SELECT *
FROM Movies
WHERE release_year > 2020;

-- 5. Display movies with a duration between 90 and 120 minutes
SELECT title, duration_minutes
FROM Movies
WHERE duration_minutes BETWEEN 90 AND 120;

-- 6. Find movies whose titles start with 'A'
SELECT *
FROM Movies
WHERE title LIKE 'A%';

-- 7. Find movies with missing descriptions
SELECT *
FROM Movies
WHERE description IS NULL;

-- 8. Display the 5 most recently released movies
SELECT title, release_year
FROM Movies
ORDER BY release_year DESC
LIMIT 5;


--Filtering and sorting


-- 9. Find movies released in 2022 or 2023
SELECT *
FROM Movies
WHERE release_year IN (2022, 2023);

-- 10. Find movies that are not in English
SELECT title, language
FROM Movies
WHERE language <> 'English';

-- 11. Find users whose names contain 'an'
SELECT *
FROM Users
WHERE name LIKE '%an%';

-- 12. Display subscriptions that are currently active
SELECT *
FROM Subscriptions
WHERE status = 'Active';

-- 13. Find profiles with an age limit of at least 18
SELECT *
FROM Profiles
WHERE age_limit >= 18;

-- 14. Display movies in alphabetical order
SELECT title
FROM Movies
ORDER BY title ASC;


--Aggregate functions and GROUP BY


-- 15. Count the total number of movies
SELECT COUNT(*) AS total_movies
FROM Movies;

-- 16. Find the average movie duration
SELECT AVG(duration_minutes) AS average_duration
FROM Movies;

-- 17. Find the longest movie
SELECT title, duration_minutes
FROM Movies
ORDER BY duration_minutes DESC
LIMIT 1;

-- 18. Count movies by language
SELECT language, COUNT(*) AS movie_count
FROM Movies
GROUP BY language;

-- 19. Find languages with more than 5 movies
SELECT language, COUNT(*) AS movie_count
FROM Movies
GROUP BY language
HAVING COUNT(*) > 5;

-- 20. Find the average rating for each movie
SELECT movie_id, AVG(rating) AS average_rating
FROM Ratings
WHERE movie_id IS NOT NULL
GROUP BY movie_id;

-- 21. Count the number of profiles belonging to each user
SELECT user_id, COUNT(*) AS profile_count
FROM Profiles
GROUP BY user_id;


--JOIN queries


-- 22. Display each user's subscription plan
SELECT u.name, sp.plan_name, s.status
FROM Users u
JOIN Subscriptions s ON u.user_id = s.user_id
JOIN SubscriptionPlans sp ON s.plan_id = sp.plan_id;

-- 23. Display movies along with their genres
SELECT m.title, g.genre_name
FROM Movies m
JOIN MovieGenres mg ON m.movie_id = mg.movie_id
JOIN Genres g ON mg.genre_id = g.genre_id;

-- 24. Display episodes with their TV show titles
SELECT ts.title AS show_title,
       e.season_number,
       e.episode_number,
       e.title AS episode_title
FROM TVShows ts
JOIN Episodes e ON ts.show_id = e.show_id;

-- 25. Display users and their profiles
SELECT u.name, p.profile_name
FROM Users u
LEFT JOIN Profiles p ON u.user_id = p.user_id;

-- 26. Display movies and their ratings
SELECT m.title, r.rating
FROM Movies m
LEFT JOIN Ratings r ON m.movie_id = r.movie_id;


--Subqueries and advanced SELECT statements


-- 27. Find movies with a duration greater than the average duration
SELECT title, duration_minutes
FROM Movies
WHERE duration_minutes > (
    SELECT AVG(duration_minutes)
    FROM Movies
);

-- 28. Find users who have more than one profile
SELECT user_id, name
FROM Users
WHERE user_id IN (
    SELECT user_id
    FROM Profiles
    GROUP BY user_id
    HAVING COUNT(*) > 1
);

-- 29. Find the highest-rated movies
SELECT m.title, AVG(r.rating) AS average_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title
HAVING AVG(r.rating) = (
    SELECT MAX(avg_rating)
    FROM (
        SELECT AVG(rating) AS avg_rating
        FROM Ratings
        WHERE movie_id IS NOT NULL
        GROUP BY movie_id
    ) AS movie_averages
);

-- 30. Display each movie's rating and rank it by average rating
SELECT
    m.title,
    AVG(r.rating) AS average_rating,
    RANK() OVER (ORDER BY AVG(r.rating) DESC) AS rating_rank
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title;

