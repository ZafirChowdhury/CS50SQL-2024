SELECT "first_name", "last_name" FROM
    (SELECT "first_name", "last_name", ("salary"/"H") AS "dollars per hit"
    FROM "players"
    JOIN "performances"
    ON "players"."id" = "performances"."player_id"
    JOIN "salaries"
    ON "players"."id" = "salaries"."player_id" AND "performances"."year" = "salaries"."year"
    WHERE "performances"."year" = 2001 AND "performances"."H" > 0
    ORDER BY "dollars per hit", "first_name", "last_name"
    LIMIT 10)

INTERSECT

SELECT "first_name", "last_name" FROM
    (SELECT "first_name", "last_name", ("salary"/"RBI") AS "dollars per RBI"
    FROM "players"
    JOIN "performances"
    ON "players"."id" = "performances"."player_id"
    JOIN "salaries"
    ON "players"."id" = "salaries"."player_id" AND "performances"."year" = "salaries"."year"
    WHERE "performances"."year" = 2001 AND "performances"."RBI" > 0
    ORDER BY "dollars per RBI", "first_name", "last_name"
    LIMIT 10)

ORDER BY "last_name";
