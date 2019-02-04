#!/usr/bin/env python3
# Sara Kazemi
# CST 363
# Project 1 Part 1



# this file must be in the /cgi-bin/ directory of the server
import cgitb, cgi
import mysql.connector
import sys
cgitb.enable()
form = cgi.FieldStorage()  # Object that allows retrieval of input from form


# Check to see if what fields were filled out by the user. Assign None left blank
if 'last_name' not in form:
    last_name = None
else:
    last_name = form['last_name'].value  # get the value assigned to the last_name attribute in form

if 'first_name' not in form:
    first_name = None
else:
    first_name = form['first_name'].value  # get the value assigned to the first_name attribute in form

department = form['department'].value # get the value assigned to the department attribute in the field


# This query is triggered if all fields are filled out
qsql = 'SELECT last_name, first_name, period, course_title, room_number\
                    FROM staff s\
                    JOIN schedules sch\
                        ON s.staff_id = sch.staff_id\
                    JOIN courses c\
                        ON sch.course_id = c.course_id\
                    WHERE last_name = %s\
                    AND first_name = %s\
                    AND (department_id = %s OR department_id = 11)'


# This query is triggered if only a department is supplied
dept_query = 'SELECT last_name, first_name, period, course_title, room_number\
                    FROM staff s\
                    JOIN schedules sch\
                        ON s.staff_id = sch.staff_id\
                    JOIN courses c\
                        ON sch.course_id = c.course_id\
                    WHERE (department_id = %s)\
                    ORDER BY last_name, first_name, period'

# This query is triggered if only the last name and department are supplied
nofirst_query = 'SELECT last_name, first_name, period, course_title, room_number\
                    FROM staff s\
                    JOIN schedules sch\
                        ON s.staff_id = sch.staff_id\
                    JOIN courses c\
                        ON sch.course_id = c.course_id\
                    WHERE last_name = %s\
                    AND (department_id = %s OR department_id = 11)\
                    ORDER BY last_name, first_name, period'

# This query is triggered if only the last name is supplied
nofirst_ordept_query = 'SELECT last_name, first_name, period, course_title, room_number\
                    FROM staff s\
                    JOIN schedules sch\
                        ON s.staff_id = sch.staff_id\
                    JOIN courses c\
                        ON sch.course_id = c.course_id\
                    WHERE last_name = %s\
                    ORDER BY last_name, first_name, period'

# connect to database
cnx = mysql.connector.connect(user='root',
                                password='Chibi2019!',
                                database='sd',
                                host='127.0.0.1')

#  code to do SQL goes here
cursor = cnx.cursor()  # Creates a cursor object, which is used to execute a MySQL query


# Beginning HTML for dynamically created results page
print("Content-Type: text/html")  # HTML is following
print()  # blank line required, end of headers
print("<html><head><style> table, th, td { border: 1px solid black; padding: 15px;} </style></head><body>")


# Determines which query is triggered
if first_name != None and last_name != None and department != "0":
    #print('all fields filled')
    cursor.execute(qsql, (last_name, first_name, department))
    rows = cursor.fetchall()  # fetches the result of the SELECT clause


elif department != "0" and first_name == None and last_name == None:
    #print('only dept')
    cursor.execute(dept_query, (department, ))
    rows = cursor.fetchall()  # fetches the result of the SELECT clause

elif first_name == None and department == "0" and last_name != None:
    #print('just last name')
    cursor.execute(nofirst_ordept_query, (last_name, ))
    rows = cursor.fetchall()  # fetches the result of the SELECT clause

elif last_name != None and department != "0":
    #print('no first name')
    cursor.execute(nofirst_query, (last_name, department))
    rows = cursor.fetchall()  # fetches the result of the SELECT clause

# If no query is triggered, it means that user did not give sufficient info. Prompt to try again
else:
    print("<html><head><meta http-equiv=\"Refresh\" content=\"7; url=/staff.html\"/></head>")
    print("<body><p>Please supply a last name or department. <a href=\"/staff.html\">Return to search</a> </p></body></html>")
    sys.exit()


# Checks to see if we got results, if not, inform user to try again
if len(rows) == 0:
    print("<html><head><meta http-equiv=\"Refresh\" content=\"7; url=/staff.html\"/></head>")
    print("<body><p>No results found. <a href=\"/staff.html\">Return to search</a> </p></body></html>")
    sys.exit()

# Otherwise, show results in a nice table
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


# line below not needed since we do not alter the table
#cnx.commit()    # IMPORTANT. Must commit or else the inserts and updates will not be permanent
cnx.close()     # close the connection
