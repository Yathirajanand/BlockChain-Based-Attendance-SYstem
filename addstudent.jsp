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

		var roolNo = document.registrationForm.rno.value;
		var name = document.registrationForm.name.value;
		var dob = document.registrationForm.dob.value;
		var email = document.registrationForm.email.value;
		var phone = document.registrationForm.pno.value;
		var address = document.registrationForm.address.value;
		var uploadimage = document.registrationForm.photo.value;
		var regulation = document.registrationForm.regulation.value;
		var yearOfJoin = document.registrationForm.yearOfJoin.value;
		var currentsem = document.registrationForm.currentSem.value;
		var branch = document.registrationForm.branch.value;

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
					<li class="hvr-sweep-to-bottom"><a href="viewstudents.jsp">View
							Student</a></li>
					<li class="hvr-sweep-to-bottom"><a
						href="viewadminattandence.jsp">Attendance</a></li>
					<li class="hvr-sweep-to-bottom"><a href="logout.jsp">Logout</a></li>

				</ul>

				<br /> <br />
			</div>
		</div>
		<div id="site_content">

			<div id="content">
				<!-- insert the page content here -->

				<%
					String stauts = request.getParameter("status");

					if (stauts != null) {
				%>
				<h1><%=stauts%></h1>
				<%
					} else {
				%>
				<h1>Add Student</h1>
				<%
					}
				%>

				<form name="registrationForm" action="StudentRegistration"
					method="post" enctype="multipart/form-data">

					<div class="form_settings">
						<p>
							<span>Roll Number</span><input class="contact" type="text"
								type="text" name="rno" />
						</p>
						<p>
							<span>Name</span><input class="contact" type="text" name="name" />
						</p>

						<p>
							<span>Date of Birth</span><input class="contact" type="text"
								type="text" name="dob" />
						</p>
						<p>
							<span>Email</span><input class="contact" type="text" name="email" />
						</p>

						<p>
							<span>Phone Number</span><input class="contact" type="text"
								type="text" name="pno" />
						</p>
						<p>
							<span>Address</span><input class="contact" type="text"
								name="address" />
						</p>

						<p>
							<span>Photo</span><input class="contact" type="file" name="photo" />
						</p>
						<p>
							<span>Regulation</span><input class="contact" type="text"
								name="regulation" />
						</p>


						<p>
							<span>Year of Join</span><input class="contact" type="text"
								type="text" name="yearOfJoin" />
						</p>
						<p>
							<span>Current Sem</span><input class="contact" type="text"
								name="currentSem" />
						</p>

						<p>
							<span>Branch</span> <select class="contact" name="branch">
								<option value="null">--select--</option>
								<option value="ece">ECE</option>
								<option value="eee">EEE</option>
								<option value="cse">CSE</option>
								<option value="it">IT</option>
								<option value="mechanical">Mechanical</option>
								<option value="civil">Civil</option>
							</select>
						</p>

						<p>
							<span>Parent Email</span><input class="contact" type="text"
								name="parrentEmail" />
						</p>

						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								value="Add" onclick="return validate()" />
						</p>

					</div>
				</form>

			</div>
		</div>
	</div>
</body>
</html>
