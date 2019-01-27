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
  staff_id      				INT          	PRIMARY KEY		AUTO_INCREMENT,
  first_name   					VARCHAR(50),
  last_name						VARCHAR(50)
);

CREATE TABLE departments
(
  department_id       			INT            	PRIMARY KEY  	AUTO_INCREMENT,
  department_name     			VARCHAR(50)    	NOT NULL	 	UNIQUE
);


CREATE TABLE courses
(
	course_id					INT				PRIMARY KEY 	AUTO_INCREMENT,
    course_title				VARCHAR(60)		NOT NULL 		UNIQUE,
    department_id				INT				NOT NULL,
    CONSTRAINT courses_fk_departments
    FOREIGN KEY (department_id)
    REFERENCES departments (department_id)
);

CREATE TABLE schedules
(
  schedule_id                   INT            	PRIMARY KEY   	AUTO_INCREMENT,
  period                  		INT    			NOT NULL,
  room_number					VARCHAR(5)		NOT NULL,
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
  dept_member_id        		INT            	PRIMARY KEY   AUTO_INCREMENT,
  staff_id            			INT            	NOT NULL,
  department_id       			INT    			NOT NULL,
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
-- schedule_id, period, room_number, staff_id, course_id)
(1, 1, 902, 1, 1),
(2, 2, 902, 1, 4),
(3, 3, 902, 1, 1),
(4, 4, 902, 1, 4),
(5, 5, 902, 1, 5),
(6, 6, 902, 1, 1),
(7, 1, 301, 2, 5),
(8, 2, 301, 2, 3),
(9, 3, 301, 2, 3),
(10, 4, 301, 2, 3),
(11, 5, 301, 2, 4),
(12, 6, 301, 2, 3),
(13, 1, 404, 3, 12),
(14, 2, 404, 3, 5),
(15, 3, 404, 3, 6),
(16, 4, 404, 3, 12),
(17, 5, 404, 3, 12),
(18, 6, 404, 3, 12),
(19, 1, 210, 4, 9),
(20, 2, 210, 4, 9),
(21, 3, 210, 4, 7),
(22, 4, 210, 4, 9),
(23, 5, 210, 4, 7),
(24, 6, 210, 4, 5),
(25, 1, "GYM", 5, 11),
(26, 2, "GYM", 5, 10),
(27, 3, "GYM", 5, 11),
(28, 4, "GYM", 5, 11),
(29, 5, "GYM", 5, 5),
(30, 6, "GYM", 5, 11),
(31, 1, 153, 6, 7),
(32, 2, 153, 6, 7),
(33, 3, 153, 6, 5),
(34, 4, 153, 6, 9),
(35, 5, 153, 6, 7),
(36, 6, 153, 6, 9);

INSERT INTO department_membership VALUES
(1, 1, 7),
(2, 2, 3),
(3, 3, 7),
(4, 3, 11),
(5, 4, 4),
(6, 5, 5),
(7, 6, 4);





