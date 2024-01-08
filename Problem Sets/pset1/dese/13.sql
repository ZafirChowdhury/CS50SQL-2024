SELECT *
FROM "districts"
JOIN "schools"
ON "districts"."id" = "schools"."district_id"
JOIN "graduation_rates"
ON "schools"."id" = "graduation_rates"."school_id"
JOIN "expenditures"
ON "districts"."id" = "expenditures"."district_id"
JOIN "staff_evaluations"
ON "districts"."id" = "staff_evaluations"."district_id";
