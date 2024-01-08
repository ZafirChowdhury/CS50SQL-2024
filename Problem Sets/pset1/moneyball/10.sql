SELECT "players"."first_name", "players"."last_name", "salaries"."salary", "salaries"."year", "performances"."HR"
FROM "performances"
JOIN "players"
ON "players"."id" = "performances"."player_id"
JOIN "salaries"
ON "players"."id" = "salaries"."player_id" AND "performances"."year" = "salaries"."year"
ORDER BY "players"."id", "salaries"."year" DESC, "performances"."HR" DESC, "salaries"."salary" DESC;

-- Change the join satements
