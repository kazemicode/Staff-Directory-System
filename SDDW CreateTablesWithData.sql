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

		period		int			not null,

		staff_id	int			not null,

		course_id	int			not null,
        
        period 		int 		not null,
        
        room 		varchar(5) 	not null,

		total_courses			numeric(5),



	constraint course_schedule_pk primary key (period, staff_id, course_id),


 
	constraint staff_fk foreign key(staff_id) references staff(staff_id) 
	
	on delete no action on update no action,



	constraint period_fk foreign key(period) references period(period) 
		
	on delete no action on update no action,



	constraint course_fk foreign key(course_id) references course(course_id)
	
	on delete no action	on update no action 


);




