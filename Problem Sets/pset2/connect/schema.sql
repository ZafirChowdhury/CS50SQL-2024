CREATE TABLE "users" (
    "id" INTEGER,
    "username" TEXT UNIQUE NOT NULL,
    "password_hash" BLOB NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "locations" (
    "id" INTEGER,
    "location" TEXT,
    PRIMARY KEY ("id")
);

CREATE TABLE "educational_institutes" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "type" TEXT,
    "location_id" INTEGER,
    "established" NUMERIC,
    PRIMARY KEY("id"),
    FOREIGN KEY("location_id") REFERENCES "locations"("id")
);

CREATE TABLE "companies" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "industry" TEXT,
    "location_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("location_id") REFERENCES "locations"("id")
);

CREATE TABLE "user_user_connection" (
    "id" INTEGER,
    "user_1" INTEGER,
    "user_2" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_1") REFERENCES "users"("id"),
    FOREIGN KEY("user_2") REFERENCES "users"("id")
);

CREATE TABLE "user_edu_connection" (
    "id" INTEGER,
    "user_id" INTEGER,
    "edu_ins_id" INTEGER,
    "start_date" NUMERIC NOT NULL,
    "end_date" NUMERIC,
    "degree" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("edu_ins_id") REFERENCES "educational_institutes"("id")
);


CREATE TABLE "user_company_connection" (
    "id" INTEGER,
    "user_id" INTEGER,
    "company_id" INTEGER,
    "start_date" NUMERIC NOT NULL,
    "end_date" NUMERIC,
    "title" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("company_id") REFERENCES "companies"("id")
);
