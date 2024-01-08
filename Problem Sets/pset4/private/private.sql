CREATE TABLE IF NOT EXISTS "temp" (
    phrase TEXT
);

-- 1
INSERT INTO "temp" ("phrase")
SELECT SUBSTR("sentence", 98, 4) AS "phrase"
FROM "sentences"
WHERE "id" = 14;

-- 2
INSERT INTO "temp" ("phrase")
SELECT SUBSTR("sentence", 3, 5) AS "phrase"
FROM "sentences"
WHERE "id" = 114;

-- 3
INSERT INTO "temp" ("phrase")
SELECT SUBSTR("sentence", 72, 9) AS "phrase"
FROM "sentences"
WHERE "id" = 618;

-- 4
INSERT INTO "temp" ("phrase")
SELECT SUBSTR("sentence", 7, 3) AS "phrase"
FROM "sentences"
WHERE "id" = 630;

-- 5
INSERT INTO "temp" ("phrase")
SELECT SUBSTR("sentence", 12, 5) AS "phrase"
FROM "sentences"
WHERE "id" = 932;

-- 6
INSERT INTO "temp" ("phrase")
SELECT SUBSTR("sentence", 50, 7) AS "phrase"
FROM "sentences"
WHERE "id" = 2230;

-- 7
INSERT INTO "temp" ("phrase")
SELECT SUBSTR("sentence", 44, 10) AS "phrase"
FROM "sentences"
WHERE "id" = 2346;

-- 8
INSERT INTO "temp" ("phrase")
SELECT SUBSTR("sentence", 14, 5) AS "phrase"
FROM "sentences"
WHERE "id" = 3041;


SELECT "phrase" FROM "temp";

CREATE VIEW "message" AS
SELECT "phrase" FROM "temp";
