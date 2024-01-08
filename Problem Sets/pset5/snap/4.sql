SELECT "username"
FROM "users"
JOIN "messages"
On "users"."id" = "messages"."to_user_id"
GROUP BY "messages"."to_user_id"
ORDER BY count(*) DESC, "users"."username"
LIMIT 1;
