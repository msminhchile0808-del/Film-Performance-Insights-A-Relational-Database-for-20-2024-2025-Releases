DROP DATABASE IF EXISTS FilmInsights2024_2025;
CREATE DATABASE FilmInsights2024_2025;

-- Release_Platform
-- Where each movie is primarily released (theatrical/hybrid/streaming)
Use FilmInsights2024_2025;
Create table release_platform (
ReleasePlatformID INT auto_increment Primary key,
PlatformName Varchar(100) Not Null,
PlatformType ENUM('Streaming','Theatrical','Hybrid') NOT NULL,
CONSTRAINT uq_release_platform_name UNIQUE (PlatformName)
)ENGINE=InnoDB;

-- Rating Platform
-- Rating sources (Rotten Tomatoes, IMDB, etc.)
Use FilmInsights2024_2025;
Create table Rating_Platform (
RatingPlatformID INT auto_increment Primary Key,
PlatformName Varchar(100) NOT Null,
RatingScale INT NOT null,
CONSTRAINT uq_rating_platform_name UNIQUE (PlatformName)
)ENGINE=InnoDB;

-- Genre
Use FilmInsights2024_2025;
Create table GENRE (
GenreID INT auto_increment Primary Key,
GenreName Varchar(100) NOT NULL,
CONSTRAINT uq_genre_name UNIQUE (GenreName)
)ENGINE=InnoDB;

-- Person (Combined Actors/Actresses/Directors with genders)
Use FilmInsights2024_2025;
create table Person (
PersonID int auto_increment primary key,
FirstName Varchar(100) NOT Null,
LastName Varchar(100) not null,
Fullname Varchar(200) not null,
StageName Varchar(200) null,
Gender ENUM('male','female','non-binary','unknown') null,
DateOfBirth Date Null,
Nationality Varchar (100) null,
Stylel varchar(200) null,
Achievements Text null,
-- Generated Column Definition (normalized, persisted, indexable)
FullNameNorm VARCHAR(200) GENERATED ALWAYS AS (LOWER(TRIM(FullName))) STORED,
-- Uniqueness Constraint (prevents duplicate logical people)
CONSTRAINT uq_person_fullnamenorm UNIQUE (FullNameNorm)
)ENGINE=InnoDB;

/* ============================================================================
Person name normalization + de-duplication

WHAT:
- FullNameNorm is a GENERATED (computed) column derived from FullName using LOWER(TRIM(...)) to normalize case and strip leading/trailing spaces.
- STORED persists the computed value on disk so it can be indexed efficiently.
WHY:
- Ensures logically identical names are treated the same/
- Enables fast, reliable uniqueness checks and lookups on names.
HOW:
- GENERATED ALWAYS AS (...) recomputes FullNameNorm automatically whenever FullName changes—no app code needed.
- UNIQUE constraint on FullNameNorm guarantees one row per logical person; attempting to insert a duplicate raises an error referencing the constraint name (uq_person_fullnamenorm), making issues easy to diagnose.
========================================================================== */

-- Director
Use FilmInsights2024_2025;
create table Director (
DirectorID int Primary Key,
Stylel varchar(200) null,
Achievements Text null,
Constraint fk_director_person
foreign key (DirectorID)
References person(PersonID)
on update Cascade on delete Restrict
) ENGINE=InnoDB;

-- Movie
Use FilmInsights2024_2025;
create table Movie (
MovieID int auto_increment primary key,
title varchar(300) not null,
ReleaseDate Date not null,
ReleaseYear Year not null,
RuntimeMinutes int not null,
Country Varchar(300) not null,
ReleasePlatformID int not null,
Constraint ck_movie_release_year check (ReleaseYear Between 2024 and 2025),
Constraint uq_movie_title UNIQUE (Title),
Constraint fk_movie_release_platform
FOREIGN KEY (ReleasePlatformID) REFERENCES release_platform(ReleasePlatformID)
ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE=InnoDB;

-- Relationship Bridge Tables
-- Movie_Genre (Movie to Genre; many to many)
Use FilmInsights2024_2025;
create table Movie_Genre(
MovieID int not null,
GenreID int not null,
primary key (MovieID, GenreID),
constraint fk_movie_genre_movie foreign key (MovieID) references Movie(MovieID)
on update cascade on delete cascade,
constraint fk_movie_genre_genre foreign key (genreID) references Genre(GenreID)
on update cascade on delete restrict 
)Engine=InnoDB;

-- Movie Cast ( Movie - Person in acting roles)
Use FilmInsights2024_2025;
Create table Movie_Cast (
CastId int auto_increment primary key,
MovieID int not null,
PersonID int not null,
CharacterName varchar(200) null,
constraint fk_movie_cast_movie foreign key(MovieID) references Movie(MovieID)
on update cascade on delete restrict, 
constraint fk_movie_cast_person FOREIGN KEY (PersonID) REFERENCES person(PersonID)
on update cascade on delete restrict,
constraint uq_movie_cast_movie_person UNIQUE (MovieID, PersonID)
)engine=innodb;

-- Movie Director (Movie - Director; many to many)
Use FilmInsights2024_2025;
Create table movie_director (
MovieID int not null,
DirectorID int not null,
RoleDesciption Varchar(500) null,
primary key (MovieID, DirectorID),
CONSTRAINT fk_movie_director_movie Foreign Key (MovieID) References Movie(MovieID)
On update Cascade on delete cascade,
constraint fk_movie_director_director foreign key (DirectorID) References Director(DirectorID)
on update cascade on delete restrict
)engine=innodb;

-- Rating
Use FilmInsights2024_2025;
Create table Rating(
RatingID int auto_increment primary key,
MovieID int not null,
RatingPlatformID int not null,
RatingValue Decimal(4,2) not null,
constraint fk_rating_movie foreign key (MovieID) References Movie(MovieID)
on update cascade on delete cascade,
constraint fk_rating_platform foreign key (RatingPlatformID) References Rating_platform(RatingPlatformID)
on update cascade on delete restrict
)engine=innodb;


