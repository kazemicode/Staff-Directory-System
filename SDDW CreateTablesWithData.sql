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
	course_name		varchar(60)	not null,
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




