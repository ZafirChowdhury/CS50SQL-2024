CREATE VIEW "frequently_reviewed" AS
SELECT "listings"."id", "listings"."property_type", "listings"."host_name", COUNT("reviews"."id") AS "number of reviews"
FROM "listings"
JOIN "reviews"
ON "listings"."id" = "reviews"."listing_id"
GROUP BY "listings"."id"
ORDER BY "number of reviews" DESC;
