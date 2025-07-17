<!DOCTYPE HTML>
<%@page import="java.util.Iterator"%>
<%@page import="com.attendance.form.FacultyForm"%>
<%@page import="java.util.List"%>
<%@page import="com.attendance.dao.AppDAO"%>
<html>

<head>
<title></title>
<meta name="description" content="website description" />
<meta name="keywords" content="website keywords, website keywords" />
<meta http-equiv="content-type"
	content="text/html; charset=windows-1252" />
<link rel="stylesheet" type="text/css"
	href="http://fonts.googleapis.com/css?family=Tangerine&amp;v1" />
<link rel="stylesheet" type="text/css"
	href="http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz" />
<link rel="stylesheet" type="text/css" href="style/style.css" />

<style>
#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;
}
</style>

</head>

<body>
	<div id="main">
		<div id="header">
			<div id="logo">
				<center>
					<font color="white" size="5">Student Attendance Management
						System</font>
				</center>
			</div>
			<div id="menubar">
				<ul id="menu">
					<!-- put class="current" in the li tag for the selected page - to highlight which page you're on -->

					<li><a class="current" href="facultyhome.jsp">Home</a></li>
				<li class="hvr-sweep-to-bottom"><a href="logout.jsp">Logout</a></li>

				</ul>

				<br /> <br />
			</div>

		</div>
		<div id="site_content">

			<div id="content">
				<!-- insert the page content here -->

				<table id="customers">
					<tr>
						<th><font size="4"><b>Name</font></th>
						<th><font size="4"><b>Subjects</font></th>
						<th><font size="4"><b>Email</font></th>
						<th><font size="4"><b>Phone</font></th>
						<th><font size="4"><b>Qualification</font></th>
					</tr>
					<%
						FacultyForm facultyForm = AppDAO.getFacultyByEmail((String) request
								.getSession().getAttribute("username"));

						List<String> subjects = AppDAO.getSubjectsByFaculty(facultyForm
								.getEmail());

						String subject = "";

						Iterator<String> sit = subjects.iterator();

						while (sit.hasNext()) {
							String sub = sit.next();

							subject=subject+sub+",";

						}
					%>
					<tr>
						<td><font size="3"><%=facultyForm.getFirstName() + " "+ facultyForm.getLastName()%></font></td>
						<<td><font size="3"><%=subject.substring(0,subject.length()-1)%></font></td>
						<td><font size="3"><%=facultyForm.getEmail()%></font></td>
						<td><font size="3"><%=facultyForm.getPhoneNumber()%></font></td>
						<td><font size="3"><%=facultyForm.getQualification()%></font></td>
					</tr>


				</table>

			</div>
		</div>
	</div>
</body>
</html>
