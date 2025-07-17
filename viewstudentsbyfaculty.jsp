<!DOCTYPE HTML>
<%@page import="java.util.Iterator"%>
<%@page import="com.attendance.dao.AppDAO"%>
<%@page import="com.attendance.form.StudentForm"%>
<%@page import="java.util.List"%>
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

#customers tr:nth-child(even) {
	background-color: #f2f2f2;
}

#customers tr:hover {
	background-color: #ddd;
}

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

	</div>
	
	<br/><br/>

	<table id="customers">
		<tr>
			<th><font size="4"><b>Image</b></font></th>
			<th><font size="4"><b>RNO</b></font></th>
			<th><font size="4"><b>Name</b></font></th>
			<th><font size="4"><b>Regulation</b></font></th>
			<th><font size="4"><b>Branch</b></font></th>
			<th><font size="4"><b>Sem</b></font></th>
			<th><font size="4"><b>DOB</b></font></th>
			<th><font size="4"><b>Email</b></font></th>
			<th><font size="4"><b>Phone</b></font></th>
			<th><font size="4"><b>address</b></font></th>
		</tr>
		<%
			List<StudentForm> studentForms = AppDAO.getStudentList();

			Iterator<StudentForm> it = studentForms.iterator();

			while (it.hasNext()) {
				StudentForm studentForm = it.next();
		%>
		<tr>
			<td><a href="./uploads/<%=studentForm.getPhoto()%>" target="_blank"><img src="./uploads/<%=studentForm.getPhoto()%>"
				height="100" width="100"></a></td>
			<td><font size="3"><%=studentForm.getRno()%></font></td>
			<td><font size="3"><%=studentForm.getName()%></font></td>
			<td><font size="3"><%=studentForm.getRegulation()%></font></td>
			<td><font size="3"><%=studentForm.getBranch()%></font></td>
			<td><font size="3"><%=studentForm.getCurrentSem()%></font></td>
			<td><font size="3"><%=studentForm.getDob()%></font></td>
			<td><font size="3"><%=studentForm.getEmail()%></font></td>
			<td><font size="3"><%=studentForm.getPno()%></font></td>
			<td><font size="3"><%=studentForm.getAddress()%></font></td>
		</tr>
		<%
			}
		%>

	</table>
</body>
</html>
