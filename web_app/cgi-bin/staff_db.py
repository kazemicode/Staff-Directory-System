# login.py
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
view_sd = False
add = False
if "view_sd" in form:
    view_sd=True 
elif "add" in form:
    add=True 
print("Content-Type: text/html")    # HTML is following
print()                             # blank line required, end of headers
print("<html><body>")
print("<p>", first, last, "was added to the database.</p><br>")
qsql = 'SELECT * FROM staff'  
insert_sql = 'INSERT INTO staff (first_name, last_name) VALUES (%s, %s)'
update_sql = 'UPDATE login SET visits = visits + 1 WHERE first=%s and last=%s'

# connect to database
cnx = mysql.connector.connect(user='root',
                                password='sesame',
                                database='sd',
                                host='127.0.0.1')

 
#  code to do SQL goes here
#cursor = cnx.cursor()
#cursor.execute(qsql, (first, last))
#row = cursor.fetchone()


if add is True:	
	cursorb = cnx.cursor()
	cursorb.execute(insert_sql, (first, last))
	#visit_number = row[0] + 1				
	print('Click <a href="http://127.0.0.1:8000/Staff_db.html" target="_self">here</a>')
		
if view_sd is True:	
	print('<?php\
	try { \
	$con= new PDO("mysql:host=localhost;dbname=sd", "root", "sesame");\
	$con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);\
	$query = "SELECT * FROM staff";\
	//first pass just gets the column names\
	print "<table> n";\
	$result = $con->query($query);\
	//return only the first row (we only need field names)\
	$row = $result->fetch(PDO::FETCH_ASSOC);\
	print " <tr> n";\
	foreach ($row as $field => $value){\
	print " <th>$field</th> n";\
	} // end foreach\
	print " </tr> n";\
	//second query gets the data\
	$data = $con->query($query);\
	$data->setFetchMode(PDO::FETCH_ASSOC);\
	foreach($data as $row){\
	print " <tr> n";\
	foreach ($row as $name=>$value){\
	print " <td>$value</td> n";\
	} // end field loop\
	print " </tr> n";\
	} // end record loop\
	print "</table> n";\
	} catch(PDOException $e) {\
	echo "ERROR: " . $e->getMessage();\
	} // end try\
	?>')
	# must be first visit, insert row
	#cursorb = cnx.cursor()
	#cursorb.execute(qsql)	
	#print('Thank you for registering.  Come visit again.')

	# 
	#print('first already taken. Please select a new userid.')
print("</body></html>")
cnx.commit()
cnx.close()  # close the connection 
