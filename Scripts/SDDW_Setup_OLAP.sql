-- *****************************************************************
-- Sara Kazemi and Ryan Dorrity - Team SCSI Logic A Type
-- *****************************************************************
-- Project 1 Part 2
-- *****************************************************************


/* SD Data Warehouse star schema table */

DROP SCHEMA IF EXISTS sddw;
CREATE SCHEMA sddw;
USE sddw;


create table staff(
	staff_id 		int 		not null 	auto_increment	primary key,
	staff_name   	varchar(60)	not null
);

create table course (
	course_id		int			not null 	auto_increment 	primary key,
	course_title	varchar(60)	not null,
	department 		varchar(50)	not null
);



create table course_schedule (


		staff_id	int			not null,

		course_id	int			not null,
        
        period		int			not null,
        
        room 		varchar(5) 	not null,



	constraint course_schedule_pk primary key (staff_id, course_id, period),


 
	constraint staff_fk foreign key(staff_id) references staff(staff_id) 
	
	on delete no action on update no action,



	constraint course_fk foreign key(course_id) references course(course_id)
	
	on delete no action	on update no action 


);

/* load the sddw staff table from sd staff */

insert into sddw.staff 

(staff_id, staff_name)
 
select staff_id, concat( trim(last_name), ', ', trim(first_name))

from sd.staff;


/* load the sddw course table from sd courses */
insert into sddw.course 
(course_id, course_title, department)
select course_id, course_title, department_name
from sd.courses c JOIN
sd.departments d
WHERE c.department_id = d.department_id;

/* load the sddw course_schedules table from sd courses and sd schedules */
insert into sddw.course_schedule 
(staff_id, course_id, period, room)
select staff_id, course_id, period, room_number
from sd.schedules;




-- QUERIES

/* Which teachers are in the Math department? */
drop view if exists math_teachers;
CREATE VIEW  math_teachers AS
SELECT DISTINCT staff_name
FROM staff s
JOIN course_schedule cs
WHERE s.staff_id = cs.staff_id
AND course_id IN
(
	SELECT course_id
	FROM course
    WHERE department = "Mathematics"
);

SELECT * FROM math_teachers;


/* Which teachers teach Integrated Math III? */
drop view if exists im3_teachers;
CREATE VIEW  im3_teachers AS
SELECT DISTINCT staff_name
FROM staff s
JOIN course_schedule cs
WHERE s.staff_id = cs.staff_id
AND course_id IN
(
	SELECT course_id
	FROM course
    WHERE course_title = "Integrated Math III"
);

SELECT * FROM im3_teachers;


/* Where is Ms. Kazemi located during Period 4? */
SELECT room
FROM course_schedule
WHERE staff_id in
(
	SELECT staff_id
    FROM staff
    WHERE staff_name = "Kazemi, Sara"
)
AND period = 4;

/* During which period(s) is AP Computer Science A taught and who teaches it?*/
SELECT staff_name, period
FROM course_schedule cs
JOIN staff s
ON s.staff_id = cs.staff_id
WHERE course_id IN
(
	SELECT course_id
    FROM course
    WHERE course_title = "AP Computer Science A"
);


/* What teachers have their preparatory period during 5th period? */
drop view if exists fifth_prep;
CREATE VIEW  fifth_prep AS
SELECT staff_name
FROM staff
WHERE staff_id IN
(
	SELECT staff_id
    FROM course_schedule
    WHERE period = 5
    AND course_id IN
    (
		SELECT course_id
        FROM course
        WHERE course_title = "Prep"
	)
);
SELECT * FROM fifth_prep;


/* How many preps (distinct courses) does each teacher have? */
SELECT staff_name AS "Staff Name", COUNT(DISTINCT course_id) AS num_preps
FROM course_schedule cs
JOIN staff s
ON s.staff_id = cs.staff_id
WHERE course_id NOT IN
(SELECT course_id
FROM course
WHERE course_title = "Prep")
GROUP BY staff_name
ORDER BY num_preps DESC;

/* On average, how many preps do Sweetwater teachers have? */
SELECT AVG(t.num_preps) AS "Average Number of Preps"
FROM (
	SELECT staff_name, COUNT(DISTINCT course_id) AS num_preps
	FROM course_schedule cs
	JOIN staff s
	ON s.staff_id = cs.staff_id
	WHERE course_id NOT IN
		(SELECT course_id
		FROM course
		WHERE course_title = "Prep")
        GROUP BY staff_name
	)t;

