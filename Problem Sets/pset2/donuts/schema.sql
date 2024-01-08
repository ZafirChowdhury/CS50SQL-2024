CREATE TABLE "ingredients" (
    "id" INTEGER,
    "name" TEXT NOT NULL
);

CREATE TABLE "ingredients_price" (
    "id" INTEGER,
    "ingredient_id" INTEGER UNIQUE NOT NULL,
    "price_in_cent" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("ingredient_id") REFERENCES "ingredients"("id")
);

CREATE TABLE "donuts" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "gluten_free" INTEGER DEFAULT 0,
    "price_in_cent" INTEGER NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "donut_recipes" (
    "id" INTEGER,
    "donut_id" INTEGER,
    "ingredient_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("donut_id") REFERENCES "donuts"("id"),
    FOREIGN KEY("ingredient_id") REFERENCES "ingredients"("id")
);

CREATE TABLE "customers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "orders" (
    "id" INTEGER,
    "order_number" INTEGER,
    "customer_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("customer_id") REFERENCES "customers"("id")
);

CREATE TABLE "order_items" (
    "id" INTEGER,
    "order_id" INTEGER,
    "donut_id" INTEGER,
    "ammount" INTEGER NOT NULL DEFAULT 1,
    PRIMARY KEY("id"),
    FOREIGN KEY("order_id") REFERENCES "orders"("id"),
    FOREIGN KEY("donut_id") REFERENCES "donuts"("id")
);
