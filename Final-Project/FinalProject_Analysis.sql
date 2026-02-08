Use FilmInsights2024_2025;

Select m.Title, mc.MovieID, p.FullName, mc.PersonID, mc.CharacterName
from Movie_Cast as mc
join Person as p on p.PersonID=mc.PersonID
join Movie as m on m.MovieID = mc.MovieID;

Describe Person;
Select * from Person;

Describe Movie;
Select * from Movie;

Select p.PersonID, p.Fullname, m.MovieID, m.Title, mc.MovieID, mc.CharacterName
from Person as p
join Movie_Cast as mc on p.PersonID = mc.PersonID
join movie as m on m.MovieID = mc.MovieID;


Select  m.Title, m.ReleaseYear, m.ReleaseDate
from Person as p
join Director as d on p.PersonID = d.DirectorID
JOIN movie_director md ON md.DirectorID = d.DirectorID
JOIN movie m           ON m.MovieID    = md.MovieID
WHERE p.FullNameNorm IN ('Dave Franco','Dave Franco');



Select m.Title, r.RatingValue, p.FullName, mc.PersonID, mc.CharacterName
from Movie_Cast as mc
join Person as p on p.PersonID=mc.PersonID
join Movie as m on m.MovieID = mc.MovieID
join Rating as r on m.MovieID = r.MovieID;

SELECT
  m.MovieID,
  m.Title,
  m.ReleaseYear,
  GROUP_CONCAT(DISTINCT g.GenreName ORDER BY g.GenreName SEPARATOR ', ') AS Genres
FROM movie m
LEFT JOIN movie_genre mg ON mg.MovieID = m.MovieID
LEFT JOIN genre g ON g.GenreID = mg.GenreID
GROUP BY m.MovieID, m.Title, m.ReleaseYear
ORDER BY m.ReleaseYear DESC, m.Title ASC;

