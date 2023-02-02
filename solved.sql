-- 1.
CREATE TABLE songs (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    length FLOAT NOT NULL,
    album_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (album_id) REFERENCES albums(id)
);

-- 2.
SELECT name as "Band Name" FROM bands;

-- 3.
SELECT * FROM albums
WHERE release_year IS NOT NULL
ORDER BY release_year
LIMIT 1;

-- 4.
SELECT bands.name as "Band Name" FROM
bands LEFT JOIN albums
ON bands.id = albums.band_id
GROUP BY bands.id
HAVING COUNT(albums.id) > 0;

SELECT DISTINCT bands.name as "Band Name" FROM
bands JOIN albums
ON bands.id = albums.band_id;
-- Only use this one if count doesn't need to be displayed

-- 5.
SELECT bands.name as "Band Name" FROM
bands LEFT JOIN albums
ON bands.id = albums.band_id
WHERE albums.band_id IS NULL;

SELECT bands.name as "Band Name" FROM
bands LEFT JOIN albums
ON bands.id = albums.band_id
GROUP BY bands.id
HAVING COUNT(albums.id) < 1;

-- 6.
SELECT albums.name AS "Name",
    albums.release_year AS "Release Year",
    SUM(songs.length) AS "Duration" FROM
albums JOIN songs on albums.id = songs.album_id
GROUP BY albums.id --or song.album_id, since this is a 1:1 relationship
ORDER BY Duration DESC
LIMIT 1;

-- 7.
UPDATE albums SET release_year = 1986
WHERE release_year is NULL;

UPDATE albums
SET release_year = 1986
WHERE id = 4; --SELECT * FROM albums where release_year IS NULL;

-- 8.
INSERT INTO bands (name)
VALUES("Bruno Mars");
SELECT * FROM bands WHERE name = "Bruno Mars";

INSERT INTO albums (name, release_year, band_id)
VALUES("24K Magic", 2016, 8); -- No way around this usesage of "id" here!

SELECT * FROM
albums JOIN bands ON albums.band_id = bands.id
WHERE bands.name = "Bruno Mars";

-- 9.
DELETE FROM albums WHERE albums.name = "24K Magic"; -- or id = ?
DELETE FROM bands WHERE name = "Bruno Mars"; -- or id = ?

-- 10.
SELECT AVG(length) as "Average Song Duration" FROM songs;
