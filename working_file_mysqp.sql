-- Active: 1675210823074@@127.0.0.1@3306@record_company
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

--AGREGATE FUNCTIONS
SELECT AVG(release_year) FROM albums;
SELECT SUM(release_year) FROM albums;
SELECT band_id FROM albums
GROUP BY band_id;
-- Group cannot work when selecting other column if the
    -- grouping is not the same as the column selected

SELECT COUNT(release_year) FROM albums;
--THis counts the number of items with release year, excluding NULL

SELECT band_id, COUNT(band_id) FROM albums
GROUP BY band_id;
-- This count runs AFTER the aggregation of group.
-- now it counts the number of items in each band_id Grouping!
-- 1. GROUP BY
-- 2. SELECT Column
-- 3. COUNT band_id based on GROUPING

-----------------------------------------
/*
Next we are going to count the number of ablum by each artist!
We'll use group by and count!
But first! it's helpful to see the Joined table to figure out what to
    group by and which columns to select and COUNT!!
Execute the query below first:
*/
SELECT *
FROM bands AS b LEFT JOIN albums AS a ON b.id = a.band_id;
/*
based on the visual we can group by band.id or band.name!
    - This means that we can only select columns that are
      1:1 realationship with band.id (or band.name)

Notice that while album.band_id is almost 1:1,
there's a missing value for an artist with not albums,
THUS we can't group where a value is NULL, and we
can't/don't want to count NULL anyway

So we will select the band.id, b.name, and count ANY COLUMN in album :)
since the logic is, count the items in album (1 line for each album)
that belong to a particular band.id
*/
SELECT bands.id, bands.name, COUNT(albums.release_year)
FROM bands LEFT JOIN albums ON bands.id = albums.band_id
GROUP BY bands.id;

SELECT b.id as band_id, b.name as band_name, COUNT(a.name) as num_albums
FROM bands AS b LEFT JOIN albums AS a ON b.id = a.band_id
GROUP BY b.id;
/*
-- Same thing but with Aliases on everything
-- Remember we do the left join because some artists
    don't have an album, but we still want the count!
*/

/*
Below query won't work if we only want to have albums of a certain COUNT...
"WHERE" only applys to pre-agreated data. To get post-agregated where...
we must use "HAVING" which == where in this CONTEXT

-- SELECT b.id as band_id, b.name as band_name, COUNT(a.name) as num_albums
-- FROM bands AS b LEFT JOIN albums AS a ON b.id = a.band_id
-- GROUP BY b.id
-- WHERE num_albums = 1;
*/
SELECT b.id as band_id, b.name as band_name, COUNT(a.name) as num_albums
FROM bands AS b LEFT JOIN albums AS a ON b.id = a.band_id
GROUP BY b.id
HAVING num_albums = 1
ORDER BY band_name ASC;
-- Man the order of operations for SQL is strange...