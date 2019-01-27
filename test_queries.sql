-- Test Staff Directory
-- Should return a table of all staff's class schedules
SELECT last_name, first_name, period, course_title, room_number
FROM staff s
JOIN schedules sch
ON s.staff_id = sch.staff_id
JOIN courses c
ON sch.course_id = c.course_id;
