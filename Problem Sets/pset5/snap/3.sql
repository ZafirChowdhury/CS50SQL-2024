SELECT "messages"."to_user_id"
FROM "users"
JOIN "messages"
ON "users"."id" = "messages"."from_user_id"
WHERE "users"."username" = "creativewisdom377"
GROUP BY "messages"."to_user_id"
ORDER BY COUNT(*) DESC
LIMIT 3;
