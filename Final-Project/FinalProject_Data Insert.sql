Use FilmInsights2024_2025;

-- Insert a release platform: Theater
INSERT INTO release_platform (PlatformName, PlatformType)
VALUES ('Theater', 'Theatrical')
ON DUPLICATE KEY UPDATE
ReleasePlatformID = LAST_INSERT_ID(ReleasePlatformID),
PlatformType = VALUES(PlatformType);

-- Insert a release platform: Streaming
INSERT INTO release_platform (PlatformName, PlatformType)
VALUES 
('Fandango at Home', 'Streaming'),
('Netflix',        'Streaming'),
('Hulu',           'Streaming'),
('Peacock',        'Streaming'),
('Disney Plus',    'Streaming'),
('HBO',            'Streaming'),
('Howdy',          'Streaming'),
('Amazon Prime',   'Streaming'),
('Paramount',      'Streaming'),
('Apple Tv',       'Streaming'),
('Other',          'Streaming')
ON DUPLICATE KEY UPDATE
PlatformType = VALUES(PlatformType);

INSERT INTO rating_platform (PlatformName, RatingScale) 
VALUES ('Rotten Tomatoes', 100), ('IMDb', 10), ('Metacritic', 100), ('Letterboxd', 5), ('Common Sense Media', 5), ('Other', 100)
ON DUPLICATE KEY UPDATE
RatingPlatformID = LAST_INSERT_ID(RatingPlatformID),
RatingScale = VALUES(RatingScale);


INSERT INTO genre (GenreName) 
VALUES
('Action'),
('Adventure'),
('Animation'),
('Comedy'),
('Crime & Mystery'),
('Documentary'),
('Drama'),
('Family & Children''s'),
('Fantasy'),
('Historical'),
('Horror'),
('Musical'),
('Romance'),
('Science Fiction (Sci-Fi)'),
('Thriller & Suspense'),
('War'),
('Western'),
('Other')
ON DUPLICATE KEY UPDATE GenreID = LAST_INSERT_ID(GenreID), GenreName = VALUES(GenreName);

-- Check:
SELECT GenreID, GenreName FROM genre ORDER BY GenreName;

-- =========================================================
-- Movie: Five Nights at Freddy's 2 (2025)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Five Nights at Freddy''s 2', '2025-12-05', 2025, 104, 'USA',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Five Nights at Freddy''s 2' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Horror');
  
-- Insert rating platform
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='Five Nights at Freddy''s 2' AND ReleaseYear=2025),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
16.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Emma','Tammi','Emma Tammi','Emma Tammi','female','USA');

INSERT INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Emma Tammi'));

-- Link movie to director
INSERT INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Five Nights at Freddy''s 2'),
(SELECT PersonID FROM PERSON WHERE FullName = 'Emma Tammi'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Josh Hutcherson - Mike
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Josh','Hutcherson','Josh Hutcherson','Josh Hutcherson','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID  FROM movie  WHERE Title='Five Nights at Freddy''s 2' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Josh Hutcherson'),
'Mike';

-- Elizabeth Lail - Vanessa
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, DateOfBirth, Nationality)
VALUES ('Elizabeth','Lail','Elizabeth Lail','Elizabeth Lail','female','1992-03-25','USA')
ON DUPLICATE KEY UPDATE DateOfBirth = VALUES(DateOfBirth);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID  FROM movie  WHERE Title='Five Nights at Freddy''s 2' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Elizabeth Lail'),
'Vanessa';

-- Piper Rubio - Abby
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Piper','Rubio','Piper Rubio','Piper Rubio','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID  FROM movie  WHERE Title='Five Nights at Freddy''s 2' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Piper Rubio'),
'Abby';

-- Mckenna Grace - Lisa
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, DateOfBirth, Nationality)
VALUES ('Mckenna','Grace','Mckenna Grace','Mckenna Grace','female','2006-06-25','USA')
ON DUPLICATE KEY UPDATE DateOfBirth = VALUES(DateOfBirth);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID  FROM movie  WHERE Title='Five Nights at Freddy''s 2' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Mckenna Grace'),
'Lisa';
  
-- =======================================================================================================
-- REGREETTING YOU

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Regretting You', '2025-10-01', 2025, 116, 'USA',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName='Theater'))
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

INSERT IGNORE INTO Movie_Genre (MovieID, GenreID)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Regretting You' AND ReleaseYear=2025),
(SELECT GenreID FROM GENRE WHERE GenreName = 'Drama'));
  
INSERT IGNORE INTO Rating (MovieID, RatingPlatformID, RatingValue) 
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Regretting You'AND ReleaseYear=2025),
(SELECT RatingPlatformID FROM Rating_Platform WHERE PlatformName = 'Rotten Tomatoes'),
85.00);

-- Director
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Josh','Boone','Josh Boone','Josh Boone','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO director (DirectorID)
SELECT PersonID FROM person WHERE FullName='Josh Boone';

INSERT IGNORE INTO movie_director (MovieID, DirectorID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Regretting You' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Josh Boone');

-- Cast
-- Allison Williams - Morgan Grant
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Allison','Williams','Allison Williams','Allison Williams','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);
INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Regretting You' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Allison Williams'),
'Morgan Grant';

-- Mckenna Grace - Clara Grant
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, DateOfBirth, Nationality)
VALUES ('Mckenna','Grace','Mckenna Grace','Mckenna Grace','female','2006-06-25','USA')
ON DUPLICATE KEY UPDATE DateOfBirth = VALUES(DateOfBirth);
INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Regretting You' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Mckenna Grace'),
'Clara Grant';

-- Dave Franco - Jonah Sullivan

INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, DateOfBirth, Nationality)
VALUES ('Dave','Franco','Dave Franco','Dave Franco','male','1985-06-12','USA')
ON DUPLICATE KEY UPDATE 
StageName   = VALUES(StageName),
Gender      = VALUES(Gender),
DateOfBirth = VALUES(DateOfBirth),
Nationality = VALUES(Nationality),
Achievements= VALUES(Achievements);
INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Regretting You' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Dave Franco'),
'Jonah Sullivan';
  
-- Mason Thames → Miller Adams
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Mason','Thames','Mason Thames','Mason Thames','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);
INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Regretting You' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Mason Thames'),
'Miller Adams';

-- Sam Morelos - Lexie
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Sam','Morelos','Sam Morelos','Sam Morelos','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);
INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Regretting You' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Sam Morelos'),
'Lexie';

-- Scott Eastwood - Chris Grant
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Scott','Eastwood','Scott Eastwood','Scott Eastwood','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);
INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Regretting You' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Scott Eastwood'),
'Chris Grant';

-- Willa Fitzgerald - Jenny Davidson
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Willa','Fitzgerald','Willa Fitzgerald','Willa Fitzgerald','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);
INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Regretting You' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Willa Fitzgerald'),
'Jenny Davidson';

-- Clancy Brown - Hank "Gramps" Adams Sr.
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Clancy','Brown','Clancy Brown','Clancy Brown','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);
INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Regretting You' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Clancy Brown'),
'Hank "Gramps" Adams Sr.';

-- Ethan Costanilla - Efren
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Ethan','Costanilla','Ethan Costanilla','Ethan Costanilla','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);
INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Regretting You' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Ethan Costanilla'),
'Efren';

-- =========================================================
-- Movie: Together (2025)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Together', '2025-07-30', 2025, 102, 'Australia, USA',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Together' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Horror');

-- (Optional) if you track "Body Horror" as a genre, uncomment:
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Together' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Thriller & Suspense');

-- Insert rating platform (Rotten Tomatoes)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='Together' AND ReleaseYear=2025),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
90.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Michael','Shanks','Michael Shanks','Michael Shanks','male','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Michael Shanks'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Together' AND ReleaseYear=2025),
(SELECT PersonID FROM PERSON WHERE FullName = 'Michael Shanks'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Dave Franco - Tim
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, DateOfBirth, Nationality)
VALUES ('Dave','Franco','Dave Franco','Dave Franco','male','1985-06-12','USA')
ON DUPLICATE KEY UPDATE DateOfBirth = VALUES(DateOfBirth);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Together' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Dave Franco'),
'Tim';

-- Alison Brie - Millie
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, DateOfBirth, Nationality)
VALUES ('Alison','Brie','Alison Brie','Alison Brie','female','1982-12-29','USA')
ON DUPLICATE KEY UPDATE DateOfBirth = VALUES(DateOfBirth);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Together' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Alison Brie'),
'Millie';

-- Damon Herriman - Jamie
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, DateOfBirth, Nationality)
VALUES ('Damon','Herriman','Damon Herriman','Damon Herriman','male','1970-03-31','Australia')
ON DUPLICATE KEY UPDATE DateOfBirth = VALUES(DateOfBirth);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Together' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Damon Herriman'),
'Jamie';

-- Mia Morrissey - Cath
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Mia','Morrissey','Mia Morrissey','Mia Morrissey','female','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Together' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Mia Morrissey'),
'Cath';

-- =========================================================
-- Movie: What We Hide (2025)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('What We Hide', '2025-08-08', 2025, 103, 'USA',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='What We Hide' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Drama');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='What We Hide' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Thriller & Suspense');

-- Insert rating platform (Rotten Tomatoes critics score)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='What We Hide' AND ReleaseYear=2025),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
82.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Dan','Kay','Dan Kay','Dan Kay','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Dan Kay'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'What We Hide' AND ReleaseYear=2025),
(SELECT PersonID FROM PERSON WHERE FullName = 'Dan Kay'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Mckenna Grace - Sadie "Spider"
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, DateOfBirth, Nationality)
VALUES ('Mckenna','Grace','Mckenna Grace','Mckenna Grace','female','2006-06-25','USA')
ON DUPLICATE KEY UPDATE DateOfBirth = VALUES(DateOfBirth);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID  FROM movie  WHERE Title='What We Hide' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Mckenna Grace'),
'Sadie "Spider"';

-- Jojo Regina - Jessie
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Jojo','Regina','Jojo Regina','Jojo Regina','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID  FROM movie  WHERE Title='What We Hide' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Jojo Regina'),
'Jessie';

-- Jesse Williams - Sheriff Ben Jeffries
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Jesse','Williams','Jesse Williams','Jesse Williams','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID  FROM movie  WHERE Title='What We Hide' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Jesse Williams'),
'Sheriff Ben Jeffries';

-- Dacre Montgomery - Reece
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Dacre','Montgomery','Dacre Montgomery','Dacre Montgomery','male','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID  FROM movie  WHERE Title='What We Hide' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Dacre Montgomery'),
'Reece';

-- Forrest Goodluck - Cody
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Forrest','Goodluck','Forrest Goodluck','Forrest Goodluck','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID  FROM movie  WHERE Title='What We Hide' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Forrest Goodluck'),
'Cody';

-- Malia Baker - Alexis
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Malia','Baker','Malia Baker','Malia Baker','female','Canada')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID  FROM movie  WHERE Title='What We Hide' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Malia Baker'),
'Alexis';

-- =========================================================
-- Movie: Ghostbusters: Frozen Empire (2024)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Ghostbusters: Frozen Empire', '2024-03-22', 2024, 115, 'USA',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Ghostbusters: Frozen Empire' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Comedy');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Ghostbusters: Frozen Empire' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Fantasy');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Ghostbusters: Frozen Empire' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Adventure');

-- Insert rating platform (Rotten Tomatoes Tomatometer)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='Ghostbusters: Frozen Empire' AND ReleaseYear=2024),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
42.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Gil','Kenan','Gil Kenan','Gil Kenan','male','USA')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Gil Kenan'));

-- Link movie to director
INSERT INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Ghostbusters: Frozen Empire' AND ReleaseYear=2024),
(SELECT PersonID FROM PERSON WHERE FullName = 'Gil Kenan'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Paul Rudd - Gary Grooberson
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Paul','Rudd','Paul Rudd','Paul Rudd','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Ghostbusters: Frozen Empire' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Paul Rudd'),
'Gary Grooberson';

-- Carrie Coon - Callie Spengler
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Carrie','Coon','Carrie Coon','Carrie Coon','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Ghostbusters: Frozen Empire' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Carrie Coon'),
'Callie Spengler';

-- Finn Wolfhard - Trevor Spengler
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Finn','Wolfhard','Finn Wolfhard','Finn Wolfhard','male','Canada')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Ghostbusters: Frozen Empire' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Finn Wolfhard'),
'Trevor Spengler';

-- Mckenna Grace - Phoebe Spengler
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, DateOfBirth, Nationality)
VALUES ('Mckenna','Grace','Mckenna Grace','Mckenna Grace','female','2006-06-25','USA')
ON DUPLICATE KEY UPDATE DateOfBirth = VALUES(DateOfBirth);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Ghostbusters: Frozen Empire' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Mckenna Grace'),
'Phoebe Spengler';

-- =========================================================
-- Movie: Anniversary (2025)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Anniversary', '2025-10-29', 2025, 111, 'USA',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres
-- Rotten Tomatoes lists it as "Mystery & Thriller", so we’ll map to Thriller
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Anniversary' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Thriller & Suspense');

-- Optional: if your genre table has Mystery, uncomment:
-- INSERT IGNORE INTO movie_genre (MovieID, GenreID)
-- SELECT
-- (SELECT MovieID FROM movie WHERE Title='Anniversary' AND ReleaseYear=2025),
-- (SELECT GenreID FROM genre WHERE GenreName = 'Mystery');

-- Optional: if you also track Drama, uncomment:
-- INSERT IGNORE INTO movie_genre (MovieID, GenreID)
-- SELECT
-- (SELECT MovieID FROM movie WHERE Title='Anniversary' AND ReleaseYear=2025),
-- (SELECT GenreID FROM genre WHERE GenreName = 'Drama');

-- Insert rating platform (Rotten Tomatoes Tomatometer)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='Anniversary' AND ReleaseYear=2025),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
66.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Jan','Komasa','Jan Komasa','Jan Komasa','male','Poland')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Jan Komasa'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Anniversary' AND ReleaseYear=2025),
(SELECT PersonID FROM PERSON WHERE FullName = 'Jan Komasa'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Diane Lane - Ellen Taylor
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Diane','Lane','Diane Lane','Diane Lane','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Anniversary' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Diane Lane'),
'Ellen Taylor';

-- Kyle Chandler - Paul Taylor
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Kyle','Chandler','Kyle Chandler','Kyle Chandler','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Anniversary' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Kyle Chandler'),
'Paul Taylor';

-- Zoey Deutch - Cynthia Taylor
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Zoey','Deutch','Zoey Deutch','Zoey Deutch','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Anniversary' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Zoey Deutch'),
'Cynthia Taylor';

-- Mckenna Grace - Birdie Taylor
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, DateOfBirth, Nationality)
VALUES ('Mckenna','Grace','Mckenna Grace','Mckenna Grace','female','2006-06-25','USA')
ON DUPLICATE KEY UPDATE DateOfBirth = VALUES(DateOfBirth);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Anniversary' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Mckenna Grace'),
'Birdie Taylor';

-- Dylan O''Brien - Josh Taylor
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Dylan','O''Brien','Dylan O''Brien','Dylan O''Brien','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Anniversary' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Dylan O''Brien'),
'Josh Taylor';

-- Phoebe Dynevor - Liz Nettles
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Phoebe','Dynevor','Phoebe Dynevor','Phoebe Dynevor','female','UK')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Anniversary' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Phoebe Dynevor'),
'Liz Nettles';

-- Madeline Brewer - Anna Taylor
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Madeline','Brewer','Madeline Brewer','Madeline Brewer','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Anniversary' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Madeline Brewer'),
'Anna Taylor';

-- Daryl McCormack - Rob Taylor
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Daryl','McCormack','Daryl McCormack','Daryl McCormack','male','Ireland')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Anniversary' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Daryl McCormack'),
'Rob Taylor';


-- =========================================================
-- Movie: Slanted (2025)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Slanted', '2025-03-08', 2025, 102, 'USA',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres (Rotten Tomatoes lists: Comedy, Drama, Sci-Fi)
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Slanted' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Comedy');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Slanted' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Drama');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Slanted' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Science Fiction (Sci-Fi)');

-- Insert rating platform (Rotten Tomatoes Tomatometer)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='Slanted' AND ReleaseYear=2025),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
86.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Amy','Wang','Amy Wang','Amy Wang','female','Australia')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Amy Wang'));

-- Link movie to director
INSERT INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Slanted' AND ReleaseYear=2025),
(SELECT PersonID FROM PERSON WHERE FullName = 'Amy Wang'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Shirley Chen - Joan Huang
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Shirley','Chen','Shirley Chen','Shirley Chen','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Slanted' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Shirley Chen'),
'Joan Huang';

-- Mckenna Grace - Jo Hunt
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, DateOfBirth, Nationality)
VALUES ('Mckenna','Grace','Mckenna Grace','Mckenna Grace','female','2006-06-25','USA')
ON DUPLICATE KEY UPDATE DateOfBirth = VALUES(DateOfBirth);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Slanted' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Mckenna Grace'),
'Jo Hunt';

-- Fang Du - Roger Huang
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Fang','Du','Fang Du','Fang Du','male','China')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Slanted' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Fang Du'),
'Roger Huang';

-- Maitreyi Ramakrishnan - Brindha
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, DateOfBirth, Nationality)
VALUES ('Maitreyi','Ramakrishnan','Maitreyi Ramakrishnan','Maitreyi Ramakrishnan','female','2001-12-28','Canada')
ON DUPLICATE KEY UPDATE DateOfBirth = VALUES(DateOfBirth);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Slanted' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Maitreyi Ramakrishnan'),
'Brindha';

-- Amelie Zilber - Olivia Hammond
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Amelie','Zilber','Amelie Zilber','Amelie Zilber','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Slanted' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Amelie Zilber'),
'Olivia Hammond';

-- (Optional extra cast from Rotten Tomatoes)
-- Elaine Hendrix - Harmony
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Elaine','Hendrix','Elaine Hendrix','Elaine Hendrix','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Slanted' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Elaine Hendrix'),
'Harmony';

-- Sarah Kopkin - Greta
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Sarah','Kopkin','Sarah Kopkin','Sarah Kopkin','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Slanted' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Sarah Kopkin'),
'Greta';

-- =========================================================
-- Movie: Black Phone 2 (2025)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Black Phone 2', '2025-10-17', 2025, 116, 'USA',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Black Phone 2' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Horror');

-- Rotten Tomatoes lists "Mystery & Thriller" — map to Thriller
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Black Phone 2' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Thriller & Suspense');

-- (Optional) if you have Mystery as a genre, uncomment:
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Black Phone 2' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Crime & Mystery');

-- Insert rating platform (Rotten Tomatoes Tomatometer)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='Black Phone 2' AND ReleaseYear=2025),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
72.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Scott','Derrickson','Scott Derrickson','Scott Derrickson','male','USA')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Scott Derrickson'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Black Phone 2' AND ReleaseYear=2025),
(SELECT PersonID FROM PERSON WHERE FullName = 'Scott Derrickson'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Ethan Hawke - The Grabber
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Ethan','Hawke','Ethan Hawke','Ethan Hawke','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Black Phone 2' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Ethan Hawke'),
'The Grabber';

-- Mason Thames - Finn
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Mason','Thames','Mason Thames','Mason Thames','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Black Phone 2' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Mason Thames'),
'Finn';

-- Madeleine McGraw - Gwen
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Madeleine','McGraw','Madeleine McGraw','Madeleine McGraw','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Black Phone 2' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Madeleine McGraw'),
'Gwen';

-- Demián Bichir - Mando
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Demián','Bichir','Demián Bichir','Demián Bichir','male','Mexico')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Black Phone 2' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Demián Bichir'),
'Mando';

-- Miguel Mora - Ernesto
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Miguel','Mora','Miguel Mora','Miguel Mora','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Black Phone 2' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Miguel Mora'),
'Ernesto';

-- =========================================================
-- Movie: Monster Summer (2024)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Monster Summer', '2024-10-04', 2024, 99, 'USA',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Monster Summer' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Adventure');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Monster Summer' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Horror');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Monster Summer' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Fantasy');

-- Insert rating platform (Rotten Tomatoes Tomatometer)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='Monster Summer' AND ReleaseYear=2024),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
59.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('David','Henrie','David Henrie','David Henrie','male','USA')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'David Henrie'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Monster Summer' AND ReleaseYear=2024),
(SELECT PersonID FROM PERSON WHERE FullName = 'David Henrie'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Mason Thames - Noah Reed
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Mason','Thames','Mason Thames','Mason Thames','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Monster Summer' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Mason Thames'),
'Noah Reed';

-- Julian Lerner - Eugene Wexler
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Julian','Lerner','Julian Lerner','Julian Lerner','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Monster Summer' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Julian Lerner'),
'Eugene Wexler';

-- Abby James Witherspoon - Sammy Devers
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Abby James','Witherspoon','Abby James Witherspoon','Abby James Witherspoon','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Monster Summer' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Abby James Witherspoon'),
'Sammy Devers';

-- Lorraine Bracco - Miss Halverson
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Lorraine','Bracco','Lorraine Bracco','Lorraine Bracco','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Monster Summer' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Lorraine Bracco'),
'Miss Halverson';

-- Mel Gibson - Gene Carruthers
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Mel','Gibson','Mel Gibson','Mel Gibson','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Monster Summer' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Mel Gibson'),
'Gene Carruthers';

-- Kevin James - Edgar Palmer
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Kevin','James','Kevin James','Kevin James','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Monster Summer' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Kevin James'),
'Edgar Palmer';

-- =========================================================
-- Movie: Now You See Me: Now You Don't (2025)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Now You See Me: Now You Don''t', '2025-11-14', 2025, 112, 'USA',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres (heist/crime/thriller)
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Crime & Mystery');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Thriller & Suspense');

-- (Optional) If you also have Adventure/Comedy/Drama/Mystery genres in your table, uncomment what you want:
-- INSERT IGNORE INTO movie_genre (MovieID, GenreID)
-- SELECT (SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
--        (SELECT GenreID FROM genre WHERE GenreName = 'Adventure');
-- INSERT IGNORE INTO movie_genre (MovieID, GenreID)
-- SELECT (SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
--        (SELECT GenreID FROM genre WHERE GenreName = 'Comedy');
-- INSERT IGNORE INTO movie_genre (MovieID, GenreID)
-- SELECT (SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
--        (SELECT GenreID FROM genre WHERE GenreName = 'Drama');
-- INSERT IGNORE INTO movie_genre (MovieID, GenreID)
-- SELECT (SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
--        (SELECT GenreID FROM genre WHERE GenreName = 'Mystery');

-- Insert rating platform (Rotten Tomatoes Tomatometer)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
60.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Ruben','Fleischer','Ruben Fleischer','Ruben Fleischer','male','USA')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Ruben Fleischer'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT PersonID FROM PERSON WHERE FullName = 'Ruben Fleischer'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Jesse Eisenberg - J. Daniel Atlas
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Jesse','Eisenberg','Jesse Eisenberg','Jesse Eisenberg','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Jesse Eisenberg'),
'J. Daniel Atlas';

-- Woody Harrelson - Merritt McKinney
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Woody','Harrelson','Woody Harrelson','Woody Harrelson','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Woody Harrelson'),
'Merritt McKinney';

-- Dave Franco - Jack Wilder
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Dave','Franco','Dave Franco','Dave Franco','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Dave Franco'),
'Jack Wilder';

-- Isla Fisher - Henley Reeves
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Isla','Fisher','Isla Fisher','Isla Fisher','female','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Isla Fisher'),
'Henley Reeves';

-- Justice Smith - Charlie Gees / Charlie Vanderberg
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Justice','Smith','Justice Smith','Justice Smith','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Justice Smith'),
'Charlie Gees / Charlie Vanderberg';

-- Dominic Sessa - Bosco LeRoy
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Dominic','Sessa','Dominic Sessa','Dominic Sessa','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Dominic Sessa'),
'Bosco LeRoy';

-- Ariana Greenblatt - June Rouclere
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Ariana','Greenblatt','Ariana Greenblatt','Ariana Greenblatt','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Ariana Greenblatt'),
'June Rouclere';

-- Lizzy Caplan - Lula May
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Lizzy','Caplan','Lizzy Caplan','Lizzy Caplan','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Lizzy Caplan'),
'Lula May';

-- Rosamund Pike - Veronika Vanderberg
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Rosamund','Pike','Rosamund Pike','Rosamund Pike','female','UK')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Rosamund Pike'),
'Veronika Vanderberg';

-- Morgan Freeman - Thaddeus Bradley
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Morgan','Freeman','Morgan Freeman','Morgan Freeman','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Morgan Freeman'),
'Thaddeus Bradley';

-- Mark Ruffalo - Dylan Shrike
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Mark','Ruffalo','Mark Ruffalo','Mark Ruffalo','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Now You See Me: Now You Don''t' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Mark Ruffalo'),
'Dylan Shrike';

-- =========================================================
-- Movie: Love Lies Bleeding (2024)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Love Lies Bleeding', '2024-03-15', 2024, 104, 'United Kingdom, United States',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres (mapped from RT categories: Mystery & Thriller, Crime, Drama, Action, LGBTQ+)
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Love Lies Bleeding' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Thriller & Suspense');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Love Lies Bleeding' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Crime & Mystery');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Love Lies Bleeding' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Drama');

-- Optional: if your genre table has Action
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Love Lies Bleeding' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Action');

-- Insert rating platform (Rotten Tomatoes Tomatometer)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='Love Lies Bleeding' AND ReleaseYear=2024),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
94.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Rose','Glass','Rose Glass','Rose Glass','female','United Kingdom')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Rose Glass'));

-- Link movie to director
INSERT INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Love Lies Bleeding' AND ReleaseYear=2024),
(SELECT PersonID FROM PERSON WHERE FullName = 'Rose Glass'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Kristen Stewart - Lou
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Kristen','Stewart','Kristen Stewart','Kristen Stewart','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Love Lies Bleeding' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Kristen Stewart'),
'Lou';

-- Katy O''Brian - Jackie
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Katy','O''Brian','Katy O''Brian','Katy O''Brian','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Love Lies Bleeding' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Katy O''Brian'),
'Jackie';

-- Anna Baryshnikov - Daisy
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Anna','Baryshnikov','Anna Baryshnikov','Anna Baryshnikov','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Love Lies Bleeding' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Anna Baryshnikov'),
'Daisy';

-- Dave Franco - JJ
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, DateOfBirth, Nationality)
VALUES ('Dave','Franco','Dave Franco','Dave Franco','male','1985-06-12','USA')
ON DUPLICATE KEY UPDATE DateOfBirth = VALUES(DateOfBirth);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Love Lies Bleeding' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Dave Franco'),
'JJ';

-- Jena Malone - Beth
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Jena','Malone','Jena Malone','Jena Malone','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Love Lies Bleeding' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Jena Malone'),
'Beth';

-- Ed Harris - Lou Sr.
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Ed','Harris','Ed Harris','Ed Harris','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Love Lies Bleeding' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Ed Harris'),
'Lou Sr.';

-- =========================================================
-- Movie: M3GAN 2.0 (2025)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('M3GAN 2.0', '2025-06-27', 2025, 120, 'USA',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres (must match YOUR GenreName list exactly)
-- Action
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='M3GAN 2.0' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Action');

-- Science Fiction (Sci-Fi)
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='M3GAN 2.0' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Science Fiction (Sci-Fi)');

-- Comedy
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='M3GAN 2.0' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Comedy');

-- Insert rating platform (Rotten Tomatoes Tomatometer)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='M3GAN 2.0' AND ReleaseYear=2025),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
57.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Gerard','Johnstone','Gerard Johnstone','Gerard Johnstone','male','New Zealand')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Gerard Johnstone'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'M3GAN 2.0' AND ReleaseYear=2025),
(SELECT PersonID FROM PERSON WHERE FullName = 'Gerard Johnstone'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Allison Williams - Gemma
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Allison','Williams','Allison Williams','Allison Williams','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='M3GAN 2.0' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Allison Williams'),
'Gemma';

-- Violet McGraw - Cady
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Violet','McGraw','Violet McGraw','Violet McGraw','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='M3GAN 2.0' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Violet McGraw'),
'Cady';

-- Amie Donald - M3GAN (performer)
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Amie','Donald','Amie Donald','Amie Donald','female','New Zealand')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='M3GAN 2.0' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Amie Donald'),
'M3GAN';

-- Jenna Davis - M3GAN (voice)
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Jenna','Davis','Jenna Davis','Jenna Davis','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='M3GAN 2.0' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Jenna Davis'),
'M3GAN (voice)';

-- Ivanna Sakhno - Amelia
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Ivanna','Sakhno','Ivanna Sakhno','Ivanna Sakhno','female','Ukraine')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='M3GAN 2.0' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Ivanna Sakhno'),
'Amelia';

-- Brian Jordan Alvarez - Cole
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Brian Jordan','Alvarez','Brian Jordan Alvarez','Brian Jordan Alvarez','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='M3GAN 2.0' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Brian Jordan Alvarez'),
'Cole';

-- =========================================================
-- Movie: The Beekeeper (2024)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('The Beekeeper', '2024-01-12', 2024, 105, 'United States, United Kingdom',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres (must match YOUR GenreName list exactly)
-- Action
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Beekeeper' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Action');

-- Thriller & Suspense
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Beekeeper' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Thriller & Suspense');

-- Insert rating platform (Rotten Tomatoes Tomatometer)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Beekeeper' AND ReleaseYear=2024),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
71.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('David','Ayer','David Ayer','David Ayer','male','USA')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'David Ayer'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'The Beekeeper' AND ReleaseYear=2024),
(SELECT PersonID FROM PERSON WHERE FullName = 'David Ayer'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Jason Statham - Adam Clay
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Jason','Statham','Jason Statham','Jason Statham','male','UK')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Beekeeper' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Jason Statham'),
'Adam Clay';

-- Emmy Raver-Lampman - Verona Parker
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Emmy','Raver-Lampman','Emmy Raver-Lampman','Emmy Raver-Lampman','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Beekeeper' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Emmy Raver-Lampman'),
'Verona Parker';

-- Josh Hutcherson - Derek Danforth
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Josh','Hutcherson','Josh Hutcherson','Josh Hutcherson','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Beekeeper' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Josh Hutcherson'),
'Derek Danforth';

-- Jeremy Irons - Wallace Westwyld
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Jeremy','Irons','Jeremy Irons','Jeremy Irons','male','UK')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Beekeeper' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Jeremy Irons'),
'Wallace Westwyld';

-- Minnie Driver - Janet Harward
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Minnie','Driver','Minnie Driver','Minnie Driver','female','UK')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Beekeeper' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Minnie Driver'),
'Janet Harward';

-- =========================================================
-- Movie: Long Gone Heroes (2024)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Long Gone Heroes', '2024-09-20', 2024, 92, 'USA',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres (must match YOUR GenreName list exactly)
-- Action
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Long Gone Heroes' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Action');

-- Mystery & Thriller -> Thriller & Suspense
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Long Gone Heroes' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Thriller & Suspense');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Long Gone Heroes' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Crime & Mystery');

-- Insert rating platform (Rotten Tomatoes Tomatometer)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='Long Gone Heroes' AND ReleaseYear=2024),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
55.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('John','Swab','John Swab','John Swab','male','USA')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'John Swab'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Long Gone Heroes' AND ReleaseYear=2024),
(SELECT PersonID FROM PERSON WHERE FullName = 'John Swab'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Frank Grillo - Gunner
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Frank','Grillo','Frank Grillo','Frank Grillo','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Long Gone Heroes' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Frank Grillo'),
'Gunner';

-- Josh Hutcherson - David
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Josh','Hutcherson','Josh Hutcherson','Josh Hutcherson','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Long Gone Heroes' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Josh Hutcherson'),
'David';

-- Mekhi Phifer - Moreau
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Mekhi','Phifer','Mekhi Phifer','Mekhi Phifer','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Long Gone Heroes' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Mekhi Phifer'),
'Moreau';

-- Eden Brolin - Julia Peterson
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Eden','Brolin','Eden Brolin','Eden Brolin','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Long Gone Heroes' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Eden Brolin'),
'Julia Peterson';

-- Melissa Leo - Senator Olivia Peterson
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Melissa','Leo','Melissa Leo','Melissa Leo','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Long Gone Heroes' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Melissa Leo'),
'Senator Olivia Peterson';

-- Andy García - Roman
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Andy','García','Andy García','Andy García','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Long Gone Heroes' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Andy García'),
'Roman';

-- =========================================================
-- Movie: The Fox (2025)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('The Fox', '2025-10-19', 2025, 90, 'Australia',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres (must match YOUR GenreName list exactly)
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Fox' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Fantasy');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Fox' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Comedy');

INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Fox' AND ReleaseYear=2025),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
0.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Dario','Russo','Dario Russo','Dario Russo','male','Australia')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Dario Russo'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'The Fox' AND ReleaseYear=2025),
(SELECT PersonID FROM PERSON WHERE FullName = 'Dario Russo'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Jai Courtney - Nick
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Jai','Courtney','Jai Courtney','Jai Courtney','male','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Fox' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Jai Courtney'),
'Nick';

-- Emily Browning - Kori
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Emily','Browning','Emily Browning','Emily Browning','female','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Fox' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Emily Browning'),
'Kori';

-- Damon Herriman - Derek
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Damon','Herriman','Damon Herriman','Damon Herriman','male','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Fox' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Damon Herriman'),
'Derek';

-- Sam Neill (voice)
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Sam','Neill','Sam Neill','Sam Neill','male','New Zealand')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Fox' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Sam Neill'),
'Voice';

-- Olivia Colman (voice)
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Olivia','Colman','Olivia Colman','Olivia Colman','female','UK')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='The Fox' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Olivia Colman'),
'Voice';

-- =========================================================
-- Movie: How to Make Gravy (2024)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('How to Make Gravy', '2024-12-01', 2024, 120, 'Australia',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Other')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres (must match YOUR GenreName list exactly)
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='How to Make Gravy' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Drama');

-- Insert rating platform (Rotten Tomatoes Tomatometer)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='How to Make Gravy' AND ReleaseYear=2024),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
84.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Nick','Waterman','Nick Waterman','Nick Waterman','male','Australia')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO director (DirectorID)
VALUES ((SELECT PersonID FROM person WHERE FullName = 'Nick Waterman'));

-- Link movie to director
INSERT IGNORE INTO movie_director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM movie WHERE Title='How to Make Gravy' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName = 'Nick Waterman'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Daniel Henshall - Joe
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Daniel','Henshall','Daniel Henshall','Daniel Henshall','male','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='How to Make Gravy' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Daniel Henshall'),
'Joe';

-- Brenton Thwaites - Dan
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Brenton','Thwaites','Brenton Thwaites','Brenton Thwaites','male','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='How to Make Gravy' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Brenton Thwaites'),
'Dan';

-- Kate Mulvany - Stella
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Kate','Mulvany','Kate Mulvany','Kate Mulvany','female','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='How to Make Gravy' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Kate Mulvany'),
'Stella';

-- Damon Herriman - Roger
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Damon','Herriman','Damon Herriman','Damon Herriman','male','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='How to Make Gravy' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Damon Herriman'),
'Roger';

-- Agathe Rousselle - Rita
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Agathe','Rousselle','Agathe Rousselle','Agathe Rousselle','female','France')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='How to Make Gravy' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Agathe Rousselle'),
'Rita';

-- Jonah Wren Phillips - Angus
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Jonah Wren','Phillips','Jonah Wren Phillips','Jonah Wren Phillips','male','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='How to Make Gravy' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Jonah Wren Phillips'),
'Angus';

-- Kieran Darcy-Smith - Red
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Kieran','Darcy-Smith','Kieran Darcy-Smith','Kieran Darcy-Smith','male','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='How to Make Gravy' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Kieran Darcy-Smith'),
'Red';

-- Hugo Weaving - Noel
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Hugo','Weaving','Hugo Weaving','Hugo Weaving','male','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='How to Make Gravy' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Hugo Weaving'),
'Noel';

-- Brendan Maclean - Possum
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Brendan','Maclean','Brendan Maclean','Brendan Maclean','male','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='How to Make Gravy' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Brendan Maclean'),
'Possum';

-- Megan Washington - Kelly
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Megan','Washington','Megan Washington','Meg Washington','female','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='How to Make Gravy' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Megan Washington'),
'Kelly';

-- =========================================================
-- Movie: Better Man (2024)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Better Man', '2024-12-25', 2024, 135, 'Australia, China, France, United Kingdom, United States',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres (must match YOUR GenreName list exactly)
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Better Man' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Musical');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Better Man' AND ReleaseYear=2024),
(SELECT GenreID FROM genre WHERE GenreName = 'Drama');

-- Insert rating platform (Rotten Tomatoes Tomatometer)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='Better Man' AND ReleaseYear=2024),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
89.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Michael','Gracey','Michael Gracey','Michael Gracey','male','Australia')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Michael Gracey'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Better Man' AND ReleaseYear=2024),
(SELECT PersonID FROM PERSON WHERE FullName = 'Michael Gracey'),
'Lead Director'
);


-- Robbie Williams - Self
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Robbie','Williams','Robbie Williams','Robbie Williams','male','UK')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Better Man' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Robbie Williams'),
'Self';

-- Jonno Davies - Robbie
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Jonno','Davies','Jonno Davies','Jonno Davies','male','UK')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Better Man' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Jonno Davies'),
'Robbie';

-- Steve Pemberton - Peter
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Steve','Pemberton','Steve Pemberton','Steve Pemberton','male','UK')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Better Man' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Steve Pemberton'),
'Peter';

-- Alison Steadman - Betty
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Alison','Steadman','Alison Steadman','Alison Steadman','female','UK')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Better Man' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Alison Steadman'),
'Betty';

-- Damon Herriman - Nigel
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Damon','Herriman','Damon Herriman','Damon Herriman','male','Australia')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Better Man' AND ReleaseYear=2024),
(SELECT PersonID FROM person WHERE FullName='Damon Herriman'),
'Nigel';

-- =========================================================
-- Movie: She Dances (2025)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('She Dances', '2025-06-05', 2025, 93, 'United States',
(SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater')
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres (must match YOUR GenreName list exactly)
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='She Dances' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Comedy');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='She Dances' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Drama');

-- Family-friendly positioning (optional but fits your genre set)
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='She Dances' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Family & Children''s');


INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='She Dances' AND ReleaseYear=2025),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
0.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Rick','Gomez','Rick Gomez','Rick Gomez','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Rick Gomez'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'She Dances' AND ReleaseYear=2025),
(SELECT PersonID FROM PERSON WHERE FullName = 'Rick Gomez'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Steve Zahn - Jason
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Steve','Zahn','Steve Zahn','Steve Zahn','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='She Dances' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Steve Zahn'),
'Jason';

-- Ethan Hawke - Brian
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Ethan','Hawke','Ethan Hawke','Ethan Hawke','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='She Dances' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Ethan Hawke'),
'Brian';

-- Sonequa Martin-Green - Jamie
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Sonequa','Martin-Green','Sonequa Martin-Green','Sonequa Martin-Green','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='She Dances' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Sonequa Martin-Green'),
'Jamie';

-- Mackenzie Ziegler - Kat
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Mackenzie','Ziegler','Mackenzie Ziegler','Mackenzie Ziegler','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='She Dances' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Mackenzie Ziegler'),
'Kat';

-- Rosemarie DeWitt - Deb
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Rosemarie','DeWitt','Rosemarie DeWitt','Rosemarie DeWitt','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='She Dances' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Rosemarie DeWitt'),
'Deb';

-- Audrey Zahn - Claire
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Audrey','Zahn','Audrey Zahn','Audrey Zahn','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='She Dances' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Audrey Zahn'),
'Claire';

-- =========================================================
-- Movie: Blue Moon (2025)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Blue Moon', '2025-10-24', 2025, 100, 'USA',
    COALESCE(
        (SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater'),
        (SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Fandango at Home')
    )
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres (must match YOUR GenreName list exactly)
-- RT lists: Comedy, Drama, Biography, Music -> map Biography->Historical, Music->Musical
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Blue Moon' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Comedy');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Blue Moon' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Drama');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Blue Moon' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Musical');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Blue Moon' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Historical');

-- Insert rating platform (Rotten Tomatoes Tomatometer)
INSERT INTO rating (MovieID, RatingPlatformID, RatingValue)
SELECT
(SELECT MovieID FROM movie WHERE Title='Blue Moon' AND ReleaseYear=2025),
(SELECT RatingPlatformID FROM rating_platform WHERE PlatformName='Rotten Tomatoes'),
91.00
ON DUPLICATE KEY UPDATE RatingValue = VALUES(RatingValue);

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Richard','Linklater','Richard Linklater','Richard Linklater','male','USA')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Richard Linklater'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Blue Moon' AND ReleaseYear=2025),
(SELECT PersonID FROM PERSON WHERE FullName = 'Richard Linklater'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Ethan Hawke - Lorenz Hart
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Ethan','Hawke','Ethan Hawke','Ethan Hawke','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Blue Moon' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Ethan Hawke'),
'Lorenz Hart';

-- Margaret Qualley - Elizabeth Weiland
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Margaret','Qualley','Margaret Qualley','Margaret Qualley','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Blue Moon' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Margaret Qualley'),
'Elizabeth Weiland';

-- Bobby Cannavale - Eddie
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Bobby','Cannavale','Bobby Cannavale','Bobby Cannavale','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Blue Moon' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Bobby Cannavale'),
'Eddie';

-- Andrew Scott - Richard Rodgers
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Andrew','Scott','Andrew Scott','Andrew Scott','male','Ireland')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Blue Moon' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Andrew Scott'),
'Richard Rodgers';

-- Giles Surridge - Sven
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Giles','Surridge','Giles Surridge','Giles Surridge','male','UK')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Blue Moon' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Giles Surridge'),
'Sven';

-- =========================================================
-- Movie: Captain Tsunami (2025)
-- =========================================================

INSERT INTO movie (Title, ReleaseDate, ReleaseYear, RuntimeMinutes, Country, ReleasePlatformID)
VALUES ('Captain Tsunami', '2025-06-29', 2025, 93, 'USA',
    COALESCE(
        (SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Theater'),
        (SELECT ReleasePlatformID FROM release_platform WHERE PlatformName = 'Other')
    )
)
ON DUPLICATE KEY UPDATE
RuntimeMinutes = VALUES(RuntimeMinutes),
Country = VALUES(Country),
ReleasePlatformID = VALUES(ReleasePlatformID);

-- Insert genres (must match YOUR GenreName list exactly)
-- Described as a "comic book mystery drama" -> map to Drama + Crime & Mystery
INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Captain Tsunami' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Drama');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Captain Tsunami' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Crime & Mystery');

INSERT IGNORE INTO movie_genre (MovieID, GenreID)
SELECT
(SELECT MovieID FROM movie WHERE Title='Captain Tsunami' AND ReleaseYear=2025),
(SELECT GenreID FROM genre WHERE GenreName = 'Fantasy');

-- Ratings: not available on Rotten Tomatoes (skip for now)

-- Insert director
INSERT INTO PERSON (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Aaron','Sherry','Aaron Sherry','Aaron Sherry','male','USA')
ON DUPLICATE KEY UPDATE
StageName = VALUES(StageName),
Gender = VALUES(Gender),
Nationality = VALUES(Nationality);

INSERT IGNORE INTO DIRECTOR (DirectorID)
VALUES ((SELECT PersonID FROM PERSON WHERE FullName = 'Aaron Sherry'));

-- Link movie to director
INSERT IGNORE INTO Movie_Director (MovieID, DirectorID, RoleDesciption)
VALUES (
(SELECT MovieID FROM Movie WHERE title = 'Captain Tsunami' AND ReleaseYear=2025),
(SELECT PersonID FROM PERSON WHERE FullName = 'Aaron Sherry'),
'Lead Director'
);

-- Insert cast members and link them
-- ===========================
-- Madeleine McGraw
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Madeleine','McGraw','Madeleine McGraw','Madeleine McGraw','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Captain Tsunami' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Madeleine McGraw'),
NULL;

-- P.J. Marino
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('P.J.','Marino','P.J. Marino','P.J. Marino','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Captain Tsunami' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='P.J. Marino'),
NULL;

-- Craig Frank
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Craig','Frank','Craig Frank','Craig Frank','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Captain Tsunami' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Craig Frank'),
NULL;

-- Tessa Munro
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Tessa','Munro','Tessa Munro','Tessa Munro','female','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Captain Tsunami' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Tessa Munro'),
NULL;

-- Jeremy Sisto
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Jeremy','Sisto','Jeremy Sisto','Jeremy Sisto','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Captain Tsunami' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Jeremy Sisto'),
NULL;

-- Archie Kao
INSERT INTO person (FirstName, LastName, FullName, StageName, Gender, Nationality)
VALUES ('Archie','Kao','Archie Kao','Archie Kao','male','USA')
ON DUPLICATE KEY UPDATE StageName = VALUES(StageName);

INSERT IGNORE INTO movie_cast (MovieID, PersonID, CharacterName)
SELECT
(SELECT MovieID FROM movie WHERE Title='Captain Tsunami' AND ReleaseYear=2025),
(SELECT PersonID FROM person WHERE FullName='Archie Kao'),
NULL;









