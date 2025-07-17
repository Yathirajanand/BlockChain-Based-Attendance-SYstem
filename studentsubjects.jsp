<!DOCTYPE HTML>
<%@page import="java.util.List"%>
<%@page import="com.attendance.form.StudentForm"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="com.attendance.dao.AppDAO"%>
<%@page import="java.util.Map"%>
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
				<center>
					<font color="white" size="5">Student Attendance Management
						System</font>
				</center>
			</div>
			<div id="menubar">
				<ul id="menu">
					<!-- put class="current" in the li tag for the selected page - to highlight which page you're on -->

					<li><a class="current" href="studenthome.jsp">Home</a></li>
					<li><a href="studentchangepassword.jsp">Change password</a></li>
					<li class="hvr-sweep-to-bottom"><a href="logout.jsp">Logout</a></li>
				</ul>

				<br /> <br />
			</div>

		</div>
		<div id="site_content">
			<div id="content">
				<!-- insert the page content here -->

			<%
				String percen=request.getParameter("percentage");
				String subject=request.getParameter("sub");
							
				if(percen!=null && subject!=null)
				{
			%>
				<h1> Attendance Percentage for <%=subject%> is <%=percen%></h1>
			<%		
				}
				else
				{
			%>
					<h1> Your Total Attendance Percentage is <%=AppDAO.getStudentAttendancePercentage((String)request.getSession().getAttribute("username"))%></h1>
			<%		
				}
			%>

				<form action="studentsubjects.jsp">
					<table>
						<tr>
							<td><font size="4">Select Subject</font></td>
							<td><select name="subject">

									<%	
										List<String> subjectList=AppDAO.getSubjectsByStudent((String)request.getSession().getAttribute("username"));
										
										Iterator<String> it=subjectList.iterator();
							
										while(it.hasNext())
										{
											String sub=it.next();
									%>
									<option value="<%=sub%>"><%=sub%></option>
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
					String sub=request.getParameter("subject");
					
					if(sub!=null)
					{
						float percentage=AppDAO.getStudentAttendancePercentageBySubject((String)request.getSession().getAttribute("username"), sub);
						
						String url="studentsubjects.jsp?percentage="+percentage+"&sub="+sub;

						response.sendRedirect(url);
					}
				%>

			</div>
		</div>
	</div>
</body>
</html>
