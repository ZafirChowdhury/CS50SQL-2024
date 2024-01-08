-- Common queries

-- students table
-- id is allready indexed
-- name isnt used much
-- so no index needed

-- courses table
-- deparment, number, semester needs to be indexed
-- id is allready indexed as its the PK of table
-- and title is not used as much to querie this table

-- enrollmets
-- id is allready indexed
-- student_id and course_id needs to be indexed

-- requirements table
-- From our EXPLAIN QUERY PLAN we can see requirements was not scaned much
-- I think its best not to index it

-- satisfies table
-- satisfies was scaned twice
-- but I think its best not to index it becase I think it wont be used much


-- courses
CREATE INDEX "course_index" ON "courses" ("department", "number", "semester");

-- enrollmets
CREATE INDEX "enrollmet_index" ON "enrollments" ("student_id", "course_id");
