#!/usr/bin/env python3
# Sara Kazemi
# CST 363
# Homework 1 Part 2



# this file must be in the /cgi-bin/ directory of the server
import cgitb, cgi
import mysql.connector
import sys
cgitb.enable()
form = cgi.FieldStorage()  # Object that allows retrieval of input from form

if 'last_name' not in form:
    last_name = None
else:
    last_name = form['last_name'].value  # get the value assigned to the userid attribute in form

if 'first_name' not in form:
    first_name = None
else:
    first_name = form['first_name'].value  # get the value assigned to the password attribute in form

department = form['department'].value




qsql = 'SELECT last_name, first_name, period, course_title, room_number\
                    FROM staff s\
                    JOIN schedules sch\
                        ON s.staff_id = sch.staff_id\
                    JOIN courses c\
                        ON sch.course_id = c.course_id\
                    WHERE last_name = %s\
                    AND first_name = %s\
                    AND (department_id = %s OR department_id = 11)'



dept_query = 'SELECT last_name, first_name, period, course_title, room_number\
                    FROM staff s\
                    JOIN schedules sch\
                        ON s.staff_id = sch.staff_id\
                    JOIN courses c\
                        ON sch.course_id = c.course_id\
                    WHERE (department_id = %s)\
                    ORDER BY last_name, first_name, period'

nofirst_query = 'SELECT last_name, first_name, period, course_title, room_number\
                    FROM staff s\
                    JOIN schedules sch\
                        ON s.staff_id = sch.staff_id\
                    JOIN courses c\
                        ON sch.course_id = c.course_id\
                    WHERE last_name = %s\
                    AND (department_id = %s OR department_id = 11)'


nofirst_ordept_query = 'SELECT last_name, first_name, period, course_title, room_number\
                    FROM staff s\
                    JOIN schedules sch\
                        ON s.staff_id = sch.staff_id\
                    JOIN courses c\
                        ON sch.course_id = c.course_id\
                    WHERE last_name = %s\
                    ORDER BY department_id, last_name, first_name, period'

# connect to database
cnx = mysql.connector.connect(user='root',
                                password='Chibi2019!',
                                database='sd',
                                host='127.0.0.1')


#  code to do SQL goes here
cursor = cnx.cursor()  # Creates a cursor object, which is used to execute a MySQL query
print("Content-Type: text/html")  # HTML is following
print()  # blank line required, end of headers
print("<html><head><style> table, th, td { border: 1px solid black; padding: 15px;} </style></head><body>")

if first_name != None and last_name != None and department != 0:
    cursor.execute(qsql, (last_name, first_name, department))
    rows = cursor.fetchall()  # fetches the result of the SELECT clause


elif last_name != None and department != 0:
    cursor.execute(nofirst_query, (last_name, department))
    rows = cursor.fetchall()  # fetches the result of the SELECT clause


elif department != 0:
    cursor.execute(dept_query, (department, ))
    rows = cursor.fetchall()  # fetches the result of the SELECT clause

else:
    cursor.execute(nofirst_ordept_query, (department, ))
    rows = cursor.fetchall()  # fetches the result of the SELECT clause

if len(rows) == 0:
    print("<html><head><meta http-equiv=\"Refresh\" content=\"7; url=/staff.html\"/></head>")
    print("<body><p>No results found.. <a href=\"/staff.html\">Return to search</a> </p></body></html>")
    sys.exit()
else:
    print("<table><tr><th>Last Name</th><th>First Name</th><th>Period</th><th>Course Title</th>\
                <th>Room</td></tr>")
    for row in rows:
        print("<tr>")
        for column in row:
            print("<td>", column, "</td>")
        print("</tr>")
print("</table>")
print("<a href=\"/staff.html\">Return to search</a></body></html>")



#cnx.commit()    # IMPORTANT. Must commit or else the inserts and updates will not be permanent
cnx.close()     # close the connection
