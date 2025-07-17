<!DOCTYPE HTML>
<%@page import="com.attendance.form.StudentForm"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.attendance.dao.AppDAO"%>
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

					<li><a class="current" href="adminhome.jsp">Home</a></li>
					<li class="hvr-sweep-to-bottom"><a href="viewstudents.jsp">View Student</a></li>
					<li class="hvr-sweep-to-bottom"><a href="viewadminattandence.jsp">Attendance</a></li>
					<li class="hvr-sweep-to-bottom"><a href="logout.jsp">Logout</a></li>


				</ul>
			</div>
		</div>
		<div id="site_content">
			<div id="content">
				<!-- insert the page content here -->
				<%
					String percen=request.getParameter("percentage");
					String subject=request.getParameter("sub");
					String rno=request.getParameter("rno");
								
					if(percen!=null && subject!=null && rno!=null)
					{
				%>
					<h1> Attendance Percentage for <%=subject%> is <%=percen%></h1>
					
					<br/>
					
					<h1> Your Total Attendance Percentage is <%=AppDAO.getStudentAttendancePercentage(rno)%></h1>
				<%		
					}	
				%>
				<form action="viewadminattandence.jsp">
					
					<table id="customers">
						<tr>
							<td><font size="4">Select Subject</font></td>
							<td><select name="subject">

									<%
										List<String> subjectList = AppDAO
												.getSubjectsList();

										Iterator<String> it = subjectList.iterator();

										while (it.hasNext()) {
											String sub = it.next();
									%>
									<option value="<%=sub%>"><font size="3"><%=sub%></font></option>
									<%
										}
									%>

							</select></td>
						</tr>
						<tr>
							<td><font size="4">Select Student</font></td>
							<td><select name="student">

									<%
										List<StudentForm> studentForms = AppDAO.getStudentList();

										Iterator<StudentForm> sit = studentForms.iterator();

										while (sit.hasNext()) {
											StudentForm studentForm = sit.next();
									%>
											<option value="<%=studentForm.getRno()%>"><font size="3"><%=studentForm.getRno()%></font></option>
									<%
										}
									%>

							</select></td>
						</tr>
						<tr>
							<td colspan="2" align="center"><input type="submit"
								value="Submit"></td>
						</tr>
					</table>
				</form>

				<%
					String sub = request.getParameter("subject");
					String student=request.getParameter("student");

					if (sub != null && student!=null) {
						
						float percentage = AppDAO
								.getStudentAttendancePercentageBySubject(student, sub);

						String url = "viewadminattandence.jsp?percentage=" + percentage
								+ "&sub="+sub+"&rno="+student;

						response.sendRedirect(url);
					}
				%>

			</div>
		</div>
	</div>
</body>
</html>
