-- *****************************************************************
-- Sara Kazemi and Ryan Dorrity - Team SCSI Logic A Type
-- *****************************************************************
-- This script creates the staff directory database for Project 1
-- *****************************************************************

-- ********************************************
-- CREATE THE SD DATABASE
-- *******************************************

-- create the database
DROP DATABASE IF EXISTS sd;
CREATE DATABASE sd;

-- select the database
USE sd;

-- create the tables
CREATE TABLE staff
(
  staff_id      INT          	PRIMARY KEY		AUTO_INCREMENT,
  first_name   	VARCHAR(50),
  last_name		VARCHAR(50)
);

CREATE TABLE departments
(
  department_id       INT            	PRIMARY KEY  AUTO_INCREMENT,
  department_name     VARCHAR(50)    	NOT NULL	 UNIQUE
);


CREATE TABLE courses
(
	course_id		INT			PRIMARY KEY AUTO_INCREMENT,
    course_title	VARCHAR(60)	NOT NULL 	UNIQUE,
    department_id	INT			NOT NULL,
    CONSTRAINT courses_fk_departments
    FOREIGN KEY (department_id)
    REFERENCES departments (department_id)
);

CREATE TABLE schedules
(
  schedule_id                   INT            	PRIMARY KEY   AUTO_INCREMENT,
  period                  		INT    			NOT NULL,
  room_number					INT				NOT NULL,
  staff_id						INT				NOT NULL,
  course_id						INT				NOT NULL,
  CONSTRAINT schedules_fk_staff
    FOREIGN KEY (staff_id)
    REFERENCES staff (staff_id),
      CONSTRAINT schedules_fk_courses
    FOREIGN KEY (course_id)
    REFERENCES courses (course_id)
);

CREATE TABLE department_membership
(
  dept_member_id        INT            	PRIMARY KEY   AUTO_INCREMENT,
  staff_id            	INT            	NOT NULL,
  department_id       	INT    			NOT NULL,
  CONSTRAINT dm_fk_staff
    FOREIGN KEY (staff_id)
    REFERENCES staff (staff_id),
  CONSTRAINT dm_fk_departments
    FOREIGN KEY (department_id)
    REFERENCES departments (department_id)
);


-- insert rows into the tables
INSERT INTO staff VALUES 
(1, "Robert", "Alcock III"),
(2, "Janet", "Amezcua"),
(3, "Cynthia", "Andreson"),
(4, "Alsacia", "Apodaca"),
(5, "Craig", "Balsley"),
(6, "Alicia", "Bena");

INSERT INTO departments VALUES 
(1, "Computer Science"),
(2, "Career Technical Education"),
(3, "English Language Arts"),
(4, "Mathematics"),
(5, "Physical Education"),
(6, "Science"),
(7, "Social Science"),
(8, "Special Education"),
(9, "Visual and Performing Arts"),
(10, "World Languages"),
(11, "Other");


INSERT INTO courses VALUES 
(1, "Economics", 7),
(2, "AP United States Government", 7),
(3, "English 11", 3),
(4, "English Resource", 3),
(5, "Prep", 11),
(6, "Cross-Age", 11), 
(7, "Integrated Math I", 4),
(8, "Integrated Math II", 4),
(9, "Integrated Math III", 4),
(10, "PE Course I", 5),
(11, "PE Course II", 5),
(12, "AP United States History", 7);

INSERT INTO schedules VALUES
-- id, period, room number, staffid, courseid)
(null, 1, 902, 1, 1),
(null, 2, 902, 1, 4),
(null, 3, 902, 1, 1),
(null, 4, 902, 1, 4),
(null, 5, 902, 1, 5),
(null, 6, 902, 1, 1),
(null, 1, 301, 2, 5),
(null, 2, 301, 2, 3),
(null, 3, 301, 2, 3),
(null, 4, 301, 2, 3),
(null, 5, 301, 2, 4),
(null, 6, 301, 2, 3),
(null, 1, 404, 3, 12),
(null, 2, 404, 3, 5),
(null, 3, 404, 3, 6),
(null, 4, 404, 3, 12),
(null, 5, 404, 3, 12),
(null, 6, 404, 3, 12),
(null, 1, 210, 4, 9),
(null, 2, 210, 4, 9),
(null, 3, 210, 4, 7),
(null, 4, 210, 4, 9),
(null, 5, 210, 4, 7),
(null, 6, 210, 4, 5),
(null, 1, 000, 5, 11),
(null, 2, 000, 5, 10),
(null, 3, 000, 5, 11),
(null, 4, 000, 5, 11),
(null, 5, 000, 5, 5),
(null, 6, 000, 5, 11),
(null, 1, 153, 6, 7),
(null, 2, 153, 6, 7),
(null, 3, 153, 6, 5),
(null, 4, 153, 6, 9),
(null, 5, 153, 6, 7),
(null, 1, 153, 6, 9);

INSERT INTO department_membership VALUES
(1, 1, 7),
(2, 2, 3),
(3, 3, 7),
(4, 3, 11),
(5, 4, 4),
(6, 5, 5),
(7, 6, 4);





