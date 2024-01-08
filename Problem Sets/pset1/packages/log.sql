
-- *** The Lost Letter ***

-- Too get a better idea about what the packages look like
SELECT * FROM "packages" JOIN "addresses"
ON "packages"."from_address_id" = "addresses"."id"
LIMIT 10;

-- To nail down my search with the senders address provited
SELECT * FROM "packages" JOIN "addresses"
ON "packages"."from_address_id" = "addresses"."id"
WHERE "address" = '900 Somerville Avenue';

-- Found "Congratulatory letter" in the contents with the address id 854 and package id is 384
-- To see if the delivery was made or not
SELECT * FROM "scans" WHERE "package_id" = 384;
-- We find a scan with the correct ids so the delivery was made

-- To find the name and the type of the drop location
SELECT * FROM "addresses" WHERE "id" = 854;

-- *** The Devious Delivery ***

-- mysterious fellow said that the package dose not have a sent address
-- To find the package with no from_address_id
SELECT * FROM "packages" WHERE "from_address_id" IS NULL;
-- We find out that there is only one package that has no sent address and we the its to_address_id(50) and package_id(5098)

-- To find if the package was dilivered or not
SELECT * FROM "scans" WHERE "package_id" = 5098;
-- It seems that the package was picked form the the to_address and droped at 348

-- To find the name and the type of address 348
SELECT * FROM "addresses" WHERE "id" = 348;

-- *** The Forgotten Gift ***

-- To find the package id
SELECT * FROM "packages"
JOIN "addresses" ON "packages"."from_address_id" = "addresses"."id"
WHERE "address" = '109 Tileston Street';
-- There is only 1 package and was ment to go to 4938 from 9873
-- package id is 9523

-- To make sure if the send address was right or not
SELECT * FROM "addresses" WHERE "id" = 4938;

-- To see where the package was dilivered
SELECT * FROM "scans" WHERE "package_id" = 9523;

-- Looking at the date we can say the package was picked up form 9873
-- Then droped at 7432
-- Then picked up again form 7432

-- To find the new to_address of the package
SELECT * FROM "packages" WHERE "id" = 9523 AND "from_address_id" = 7432;
-- It seems that it has not been diliverd yet or its not in the database

-- To find the location
SELECT * FROM "addresses" WHERE "id" = 7432;
-- It seems that its in a warehouse or with the driver

-- To find the drivers name
SELECT * FROM "drivers" WHERE "id" = 17;
