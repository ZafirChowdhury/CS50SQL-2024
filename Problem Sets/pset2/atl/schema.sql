CREATE TABLE "passengers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" REAL NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "concourses" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

CREATE TABLE "airlines" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "concourse_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("concourse_id") REFERENCES "concourses"("id")
);

CREATE TABLE "flights" (
    "id" INTEGER,
    "flight_number" INTEGER NOT NULL,
    "airline_id" INTEGER,
    "departure_code" TEXT NOT NULL,
    "arrival_code" TEXT NOT NULL,
    "departure_time" NUMERIC NOT NULL,
    "arrival_time" NUMERIC NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("airline_id") REFERENCES "airlines"("id")
);

CREATE TABLE "check_ins" (
    "id" INTEGER,
    "check_in_time" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    "passenger_id" INTEGER,
    "flight_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("passenger_id") REFERENCES "passengers"("id"),
    FOREIGN KEY("flight_id") REFERENCES "flights"("id")
);
