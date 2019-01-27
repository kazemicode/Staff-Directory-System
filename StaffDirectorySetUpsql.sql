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
  department_id         INT            	PRIMARY KEY  AUTO_INCREMENT,
  department_name     VARCHAR(50)    	NOT NULL	 UNIQUE
);

CREATE TABLE rooms
(
	room_number		INT		PRIMARY KEY

);

CREATE TABLE courses
(
	course_id		INT			PRIMARY KEY,
    course_title	VARCHAR(60)	NOT NULL 	UNIQUE,
    department_id			INT			NOT NULL,
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
  CONSTRAINT schedules_fk_rooms
    FOREIGN KEY (room_number)
    REFERENCES rooms (room_number),
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
  staff_id            INT            	NOT NULL,
  department_id       	INT    			NOT NULL,
  CONSTRAINT dm_fk_staff
    FOREIGN KEY (staff_id)
    REFERENCES staff (staff_id),
  CONSTRAINT dm_fk_departments
    FOREIGN KEY (department_id)
    REFERENCES departments (department_id)
);


