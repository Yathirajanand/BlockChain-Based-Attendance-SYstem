<!DOCTYPE HTML>
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

<script type="text/javascript">

			function validate() {
				
				var firstname=document.faculty.firstname.value;
				var lastname=document.faculty.lastname.value;
				var email=document.faculty.email.value;
				var qualification=document.faculty.qualification.value;
				var experience=document.faculty.experience.value;
				var phone=document.faculty.phone.value;
				var description=document.faculty.description.value;
				
				
				if(firstname=="" || firstname==null)
				{
					alert("please enter firstName");
					return false;
				}
				if(lastname=="" || lastname==null)
				{
					alert("please enter lastname");
					return false;
				}
				if(email=="" || email==null)
				{
					alert("please enter email");
					return false;
				}
				else
				{
					var atpos=email.indexOf("@");
					var dotpos=email.lastIndexOf(".");

					if (atpos<1 || dotpos<atpos+2|| dotpos+2>=email.length)
					{
						alert("Not a valid e-mail address");
						return false;
					}
				}
				if(description=="" || description==null)
				{
					alert("please enter description");
					return false;
				}
				if(phone=="" || phone==null)
				{
					alert("please enter phone");
					
					return false;
				}
				if(isNaN(phone))
				{
						alert("phone no should not have any character");
						return false;
				}

				if(phone.length!=10)
				{
					alert("phone no should have 10 numbers");
					return false;
				}
				
				if(qualification=="" || qualification==null)
				{
					alert("please enter qualification");
					return false;
				}
				if(experience=="" || experience==null)
				{
					alert("please enter experience");
					return false;
				}
			}
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
					<li class="hvr-sweep-to-bottom"><a href="viewfaculties.jsp">View
							Faculties</a></li>
					<li class="hvr-sweep-to-bottom"><a href="logout.jsp">Logout</a></li>

				</ul>

				<br /> <br />
			</div>
		</div>
		<div id="site_content">

			<div id="content">
				<!-- insert the page content here -->


				<%
					String status = request.getParameter("status");

					if (status != null) {
				%>
				<h1><%=status%></h1>
				<%
					} else {
				%>
				<h1>Add Faculty</h1>
				<%
					}
				%>

				<form name="faculty" action="FacultyRegistrationServlet"
					method="post">

					<div class="form_settings">
						<p>
							<span>First Name</span><input class="contact" type="text"
								name="firstname" />
						</p>
						<p>
							<span>Last Name</span><input class="contact" type="text"
								name="lastname" />
						</p>

						<p>
							<span>Email</span><input class="contact" type="text" type="text"
								name="email" />
						</p>
						<p>
							<span>Qualification</span><input class="contact" type="text"
								name="qualification" />
						</p>

						<p>
							<span>Experience</span><input class="contact" type="text"
								type="text" name="experience" />
						</p>
						<p>
							<span>Phone</span><input class="contact" type="text" name="phone" />
						</p>

						<p>
							<span>Description</span><input class="contact" type="text"
								type="text" name="description" />
						</p>

						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								value="submit" onclick="return validate()" />
						</p>

					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
