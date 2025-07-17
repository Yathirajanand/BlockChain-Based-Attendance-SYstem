<!DOCTYPE HTML>
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

</head>

<body>
	<div id="main">
		<div id="header">
			<div id="logo">
				<div class="slogan">
					<center>
						<font color="white" size="5">Student Attendance Management
							System</font>
					</center>
				</div>
			</div>
			<div id="menubar">
				<ul id="menu">
					<!-- put class="current" in the li tag for the selected page - to highlight which page you're on -->

					<li><a class="current" href="facultyhome.jsp">Home</a></li>
					<li class="hvr-sweep-to-bottom"><a
						href="viewfacultyattendance.jsp">View Attendance</a></li>
					<li class="hvr-sweep-to-bottom"><a href="logout.jsp">Logout</a></li>

				</ul>
			</div>
		</div>
		<div id="site_content">
			<div id="content">
				<!-- insert the page content here -->

				<form action="addattendance.jsp">
					<table>
						<tr>
							<td><font size="4">Select Subject</font></td>
							<td><select name="subject">
									<%
										List<String> subjects=AppDAO.getSubjectsByFaculty((String)request.getSession().getAttribute("username"));
										
										Iterator<String> it=subjects.iterator();
							
										while(it.hasNext())
										{
											String subject=it.next();
											
											String status=AppDAO.isAttendanceSubmitted(subject);
											
											System.out.println("subject attendance status :\t"+status);
											
											if(status.equals("no"))
											{
									%>
									<option value="<%=subject%>"><%=subject%></option>
									<%		
											}
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
					String subject=request.getParameter("subject");
					
					if(subject!=null)
					{
					   List<String> rollNumbers=AppDAO.getRollNumbersBySubject(subject);
								
				%>
				<h1>Add Attendance</h1>
				<form action="addattendance.jsp">

					<input type="hidden" value="<%=subject%>" name="subject">

					<table class="imagetable">
						<tr>
							<th>Roll Number</th>
							<th>Attendance</th>
						</tr>

						<%
	
							Iterator<String> rollIt = rollNumbers.iterator();
	
							while (rollIt.hasNext()) {
								
								String rollNumber =rollIt.next();
						%>
						<tr>
							<td><%=rollNumber%></td>
							<td><input type="checkbox" value="<%=rollNumber%>"
								name="status"></td>
						</tr>
						<%
							}
						%>
						<tr>
							<td colspan="2" align="center"><input type="submit"
								value="Submit"></td>
						</tr>
					</table>
				</form>

				<%
					}
				%>

				<% 
					String[] roolNums=request.getParameterValues("status");
					
					String sub=request.getParameter("subject");
					
					if(roolNums!=null && sub!=null)
					{
						int result=AppDAO.addAttendence(roolNums, subject);
						
						if(result==1)
						{
							response.sendRedirect("addattendance.jsp?status=success");
						}
						else
						{
							response.sendRedirect("addattendance.jsp?status=failed");
						}
					}
				%>

			</div>
		</div>
	</div>
</body>
</html>
