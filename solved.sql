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
