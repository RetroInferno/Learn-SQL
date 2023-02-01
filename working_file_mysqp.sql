DROP DATABASE IF EXISTS record_company;
CREATE DATABASE record_company;

USE record_company;

DROP TABLE IF EXISTS bands;

CREATE TABLE
    bands (
        id INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(255) NOT NULL,
        PRIMARY KEY (id)
    );

DROP TABLE IF EXISTS albums;

CREATE table
    albums (
        id INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(255) NOT NULL,
        release_year INT,
        band_id INT NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY (band_id) REFERENCES bands(id)
    );

INSERT INTO bands (name) VALUES('Iron Maiden');

INSERT INTO bands (name)
VALUES ('Deuce'), ('Avenged Sevenfold'), ('Ankor');

SELECT * FROM bands;

SELECT * FROM bands LIMIT 2;

SELECT name FROM bands;

SELECT id as 'ID', name AS 'Band Name' FROM bands;

SELECT * FROM bands ORDER BY name DESC;

INSERT INTO
    albums (name, release_year, band_id)
	VALUES ('The Number of the Beast', 1985, 1),
		('Power Slave', 1984, 1),
		('Nightmare', 2018, 2),
		('Nightmare', 2010, 3),
		('Test Ablum', NULL, 3);

SELECT * from albums;
SELECT name FROM albums;
SELECT DISTINCT name FROM albums;

UPDATE albums
SET release_year = 1982
WHERE id = 1;
SELECT * FROM albums
WHERE release_year < 2000;
SELECT * from albums
WHERE name LIKE '%er%';
--wildcard

SELECT * from albums
WHERE name LIKE '%er%' OR band_id = 2;
SELECT * from albums
WHERE release_year = 1984 AND band_id = 1;

SELECT * from albums WHERE release_year <= 2018 AND release_year >= 2000;
-- equivalent to the below, but more precise
SELECT * from albums WHERE release_year BETWEEN 2010 AND 2018;
-- For use of BETWEEN, range must be "LO" AND "HI", inslusive

SELECT * FROM albums WHERE release_year = 1984;
--Statment above and below functions very differently! IS NULL is special, so = NULL doesn't work
SELECT * FROM albums WHERE release_year IS NULL;

DELETE FROM albums WHERE release_year IS NULL;
--SAME AS:

-- JOINS

--This is an Inner Join! (both the on values have to exit!)
SELECT * FROM bands
JOIN albums ON bands.id =  albums.band_id;

SELECT * FROM bands
JOIN albums ON bands.id =  albums.band_id
WHERE albums.release_year >= 2000;

SELECT bands.id as 'artist_id',
	bands.name as 'artist_name',
	albums.id as 'album_id',
	albums.name as 'album_name',
	albums.release_year as 'year'
FROM bands
JOIN albums ON bands.id =  albums.band_id;
-- This is basically saying (SELECT these columns) FROM (bands JOIN albums (ON this Column Prop))

SELECT * FROM bands
LEFT JOIN albums ON bands.id =  albums.band_id;

SELECT * FROM albums
RIGHT JOIN bands ON bands.id =  albums.band_id;
-- some sql don't have a RIGHT JOIN, so just filp the ORDER BY

-- mysql does not have outer or full outer joins....