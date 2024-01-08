SELECT "name" FROM "districts" WHERE "id" = (
    SELECT "district_id" FROM "expenditures" WHERE "pupils" IN (
            SELECT MIN("pupils")
            FROM "districts"
            JOIN "expenditures"
            ON "districts"."id" = "expenditures"."district_id"
            ORDER BY "pupils" ASC
));
