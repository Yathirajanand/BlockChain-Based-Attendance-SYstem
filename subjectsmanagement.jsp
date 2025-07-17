<!DOCTYPE HTML>
<%@page import="com.attendance.form.FacultyForm"%>
<%@page import="java.util.Iterator"%>
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

<script src="js/jquery-1.11.1.js" type="text/javascript"></script>
<script>
$(document).ready(function() {

$('#smse').change(function(event) {
        var smse = $("select#smse").val();
        $.get('subjectsmanagement', {
                semesterName : smse
        }, function(response) {

        var select = $('#smsu');
        select.find('option').remove();
          $.each(response, function(index, value) {
          $('<option>').val(value).text(value).appendTo(select);
      });
        });
        });
});

</script>
<script>

$(document).ready(function() {

	$('#afse').change(function(event) {
	        var smse = $("select#afse").val();
	        $.get('addfacultysubject', {
	                semesterName : smse
	        }, function(response) {

	        var select = $('#afsu');
	        select.find('option').remove();
	          $.each(response, function(index, value) {
	          $('<option>').val(value).text(value).appendTo(select);
	      });
	        });
	        });
	});
</script>

<script>

$(document).ready(function() {
	
	$('#dfsf').change(function(event) {
	        var smse = $("select#dfsf").val();
	        
	         $.get('GetFacultySubjectAutoCompleteServlet', {
	                semesterName : smse
	        }, function(response) {

	        var select = $('#dfs');
	        select.find('option').remove();
	          $.each(response, function(index, value) {
	          $('<option>').val(value).text(value).appendTo(select);
	      });
	        });
	        });
	});
</script>

<script>

$(document).ready(function() {
	
	$('#dfs').change(function(event) {
	        var smse = $("select#dfs").val();
	        
	      
	        $.get('GetSemestersBySubjectAutoCompleteServlet', {
	                semesterName : smse
	        }, function(response) {

	        var select = $('#dfsse');
	        select.find('option').remove();
	          $.each(response, function(index, value) {
	          $('<option>').val(value).text(value).appendTo(select);
	      });
	        });
	        });
	});
</script>


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
					<li class="hvr-sweep-to-bottom"><a href="logout.jsp">Logout</a></li>

				</ul>

				<br /> <br />
			</div>

		</div>
		<div id="site_content">
	
			<div id="content">
				<!-- insert the page content here -->
				<h1>Manage Subjects</h1>

				<table class="imagetable">
					<tr>
						<th>Add Subjects</th>
						<th>Add Subjects to Semester</th>
					</tr>
					<tr>
						<td>
							<form action="subjectsmanagement.jsp">

								<input type="hidden" value="addsubject" name="formtype" />

								<div class="form_settings">

									<p>
										<span>Enter Subject</span><input class="contact" type="text"
											type="text" name="subject" />
									</p>

									<p style="padding-top: 15px">
										<span>&nbsp;</span><input class="submit" type="submit"
											value="Add" onclick="return validate()" />
									</p>

								</div>
							</form>
						</td>
						<td>
							<form action="subjectsmanagement.jsp">

								<input type="hidden" value="addsemestersubject" name="formtype" />

								<div class="form_settings">
									<p>
										<span>Select Semester</span> <select id="smse" class="contact"
											name="semester" required="required">

											<option value="">--select--</option>
											<option value="1-0">1st Year</option>
											<option value="2-1">2-1</option>
											<option value="2-2">2-2</option>
											<option value="3-1">3-1</option>
											<option value="3-2">3-2</option>
											<option value="4-1">4-1</option>
											<option value="4-2">4-2</option>

										</select>
									</p>

									<p>
										<span>Select Subject</span> <select id="smsu" class="contact"
											name="subject" required="required"> 

											<option value="">--select--</option>

										</select>
									</p>

									<p style="padding-top: 15px">
										<span>&nbsp;</span><input class="submit" type="submit"
											value="Add" onclick="return validate()" />
									</p>

								</div>
							</form>
						</td>
					</tr>
					<tr>
						<th>Add Subjects to Faculties</th>
						<th>Delete Subjects to Faculties</th>
					</tr>
					<tr>
						<td>

							<form action="subjectsmanagement.jsp">

								<input type="hidden" value="addfacultysubject" name="formtype" />

								<div class="form_settings">

									<p>
										<span>Select Faculty</span> <select class="contact"
											name="facultyid" required="required">
											
											<option value="">--select--</option>
											
											<% 
												List<FacultyForm> facultyForms=AppDAO.getListOfFacultys();
												
												Iterator<FacultyForm> it2=facultyForms.iterator();
												
												while(it2.hasNext())
												{
													FacultyForm facultyForm=it2.next();
													
													String facultyId=facultyForm.getEmail();
											%>
													<option value="<%=facultyId%>"><%=facultyId%></option>
											<%
												}
											%>
										</select>
									</p>

									<p>
										<span>Select Semester</span> <select id="afse" class="contact"
											name="semester" required="required">

											<option value="">--select--</option>
											<option value="1-0">1st Year</option>
											<option value="2-1">2-1</option>
											<option value="2-2">2-2</option>
											<option value="3-1">3-1</option>
											<option value="3-2">3-2</option>
											<option value="4-1">4-1</option>
											<option value="4-2">4-2</option>

										</select>
									</p>

									<p>
										<span>Select Subject</span> <select id="afsu" class="contact"
											name="subject" required="required">

											<option value="">--select--</option>

										</select>
									</p>



									<p style="padding-top: 15px">
										<span>&nbsp;</span><input class="submit" type="submit"
											value="Add" onclick="return validate()" />
									</p>

								</div>
							</form>
						</td>
						<td>
							<form action="subjectsmanagement.jsp">

								<input type="hidden" value="deletefacultysubject"
									name="formtype" />

								<div class="form_settings">

									<p>
										<span>Select Faculty</span> <select id="dfsf" class="contact"
											name="facultyid" required="required">
											<option value="">--Select--</option>

											<% 
												List<FacultyForm> facultyForms1=AppDAO.getListOfFacultys();
												
												Iterator<FacultyForm> it3=facultyForms.iterator();
												
												while(it3.hasNext())
												{
													FacultyForm facultyForm=it3.next();
													
													String facultyId=facultyForm.getEmail();
											%>
													<option value="<%=facultyId%>"><%=facultyId%></option>
											<%
												}
											%>
										</select>
									</p>

									<p>
										<span>Select Subject</span> <select class="contact"
											name="subject" id="dfs" required="required">
											<option value="">--select--</option>
										</select>
									</p>

									<p>
										<span>Select Semester</span> <select id="dfsse" class="contact"
											name="semester" required="required">
											<option value="">--select--</option>
										</select>
									</p>

									<p style="padding-top: 15px">
										<span>&nbsp;</span><input class="submit" type="submit"
											value="Delete" onclick="return validate()" />
									</p>

								</div>
							</form>
						</td>
					</tr>
				</table>


				<%
					String formType = request.getParameter("formtype");

					if (formType != null) {
						if (formType.equals("addsubject")) {
							
							AppDAO.addSubject(request.getParameter("subject"));
							
						} else {
							
							if (formType.equals("addfacultysubject")) {
								
								AppDAO.assingSubjectsToFaculty(request.getParameter("subject"),request.getParameter("semester"),request.getParameter("facultyid"));

							} else {
								if (formType.equals("addsemestersubject")) {
									
									AppDAO.addSubjectToSemister(request.getParameter("subject"),request.getParameter("semester"));
									
								} else {
									
									if (formType.equals("deletefacultysubject")) {
										
										AppDAO.deleteSubjectsToFaculty(request.getParameter("subject"),request.getParameter("semester"),request.getParameter("facultyid"));
								
									}
								}
							}
						}
					}
				%>
			</div>
		</div>
	</div>
</body>
</html>
