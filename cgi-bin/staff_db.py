#!/usr/bin/env python3
# Ryan Dorrity
# CST 363
# Project 1 Part 1

# this file must be in the /cgi-bin/ directory of the server
import cgitb , cgi
import mysql.connector
cgitb.enable()
form = cgi.FieldStorage()
#
#  code to get input values goes here
#
first = form['first'].value 
last = form['last'].value
add = False

if "add" in form:
    add=True 
print("Content-Type: text/html")    # HTML is following
print()                             # blank line required, end of headers
print("<html><body>")
print("<p>", first, last, "was added to the database.</p><br>")  
insert_sql = 'INSERT INTO staff (first_name, last_name) VALUES (%s, %s)'



# connect to database
cnx = mysql.connector.connect(user='root',
                                password='sesame', # Chibi2019! -- other server password for team member
                                database='sd',
                                host='127.0.0.1')

 
#  code to do SQL goes here
cursor = cnx.cursor()
#cursor.execute(qsql, (first, last))
#row = cursor.fetchone()


if add is True:	
	cursor = cnx.cursor()
	cursor.execute(insert_sql, (first, last))
	#visit_number = row[0] + 1				
	print('Click <a href="http://127.0.0.1:8000/Staff_db.html" target="_self">here</a> to return to the Staff Database Management System.')

print("</body></html>")
cnx.commit()
cnx.close()  # close the connection 
