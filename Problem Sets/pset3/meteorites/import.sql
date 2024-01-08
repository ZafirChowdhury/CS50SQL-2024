-- Temp table schema
CREATE TABLE meteorites_temp (
    name TEXT,
    id INTEGER,
    nametype TEXT,
    class TEXT,
    mass REAL,
    discovery TEXT,
    year REAL,
    lat REAL,
    long REAL
);

-- Initial import
.import --csv --skip 1 meteorites.csv meteorites_temp

-- Removing all meteorites with nametype "Relict"
DELETE FROM meteorites_temp WHERE "nametype" = "Relict";

-- Droping the nametype column
ALTER TABLE meteorites_temp DROP COLUMN 'nametype';

-- Rounding down all mass to 2 decimal
-- mass
UPDATE meteorites_temp SET mass = ROUND(mass, 2);

-- lat
UPDATE meteorites_temp SET lat = ROUND(lat, 2);

-- long
UPDATE meteorites_temp SET long = ROUND(long, 2);

-- Chaning all emplty strings to NULL
-- Only mass, year, lat and long has empty values
-- mass
UPDATE meteorites_temp SET mass = NULL
WHERE mass = "";

-- year
UPDATE meteorites_temp SET year = NULL
WHERE year = "";

-- lat
UPDATE meteorites_temp SET lat = NULL
WHERE lat = "";

-- long
UPDATE meteorites_temp SET long = NULL
WHERE long = "";

-- Final table schema
CREATE TABLE meteorites (
    id INTEGER PRIMARY KEY,
    name TEXT,
    class TEXT,
    mass REAL,
    discovery TEXT,
    year REAL,
    lat REAL,
    long REAL
);

-- Sorting + moving from the temp table to the final table
INSERT INTO meteorites (name, class, mass, discovery, year, lat, long)
SELECT name, class, mass, discovery, year, lat, long FROM meteorites_temp ORDER BY year, name;

-- Removing the temp table
DROP TABLE meteorites_temp;
