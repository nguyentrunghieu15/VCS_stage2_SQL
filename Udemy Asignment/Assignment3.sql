-- Asignment section 3
-- create table
DROP TABLE IF EXISTS courses;
DROP TYPE IF EXISTS course_status_mod;

CREATE TYPE course_status_mod as  ENUM ('published','draft','inactive');

CREATE TABLE courses(
    course_id serial primary key,
    course_name varchar(60) not null,
    course_author varchar(40) not null,
    course_status course_status_mod,
    course_published_dt date
);

-- insert data 
INSERT INTO courses (course_name, course_author, course_status, course_published_dt) VALUES
    ('Programming using Python', 'Bob Dillon', 'published', '2020-09-30'),
    ('Data Engineering using Python', 'Bob Dillon', 'published', '2020-07-15'),
    ('Data Engineering using Scala', 'Elvis Presley', 'draft', NULL),
    ('Programming using Scala', 'Elvis Presley', 'published', '2020-05-12'),
    ('Programming using Java', 'Mike Jack', 'inactive', '2020-08-10'),
    ('Web Applications - Python Flask', 'Bob Dillon', 'inactive', '2020-07-20'),
    ('Web Applications - Java Spring', 'Mike Jack', 'draft', NULL),
    ('Pipeline Orchestration - Python', 'Bob Dillon', 'draft', NULL),
    ('Streaming Pipelines - Python', 'Bob Dillon', 'published', '2020-10-05'),
    ('Web Applications - Scala Play', 'Elvis Presley', 'inactive', '2020-09-30'),
    ('Web Applications - Python Django', 'Bob Dillon', 'published', '2020-06-23'),
    ('Server Automation - Ansible', 'Uncle Sam', 'published', '2020-07-05');


-- Update the status of all the draft courses related to Python and Scala to published along with the course_published_dt using system date.

UPDATE courses
SET course_status = 'published', course_published_dt = now()
WHERE (course_name like '%Python%' or course_name like '%Scala%') and course_status = 'draft';


-- Delete all the courses which are neither in draft mode nor published.

DELETE FROM courses
WHERE course_status not in ('published','draft');


SELECT course_author, count(1) AS course_count
FROM courses
WHERE course_status= 'published'
GROUP BY course_author