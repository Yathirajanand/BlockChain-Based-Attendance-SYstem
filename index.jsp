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

		var email = document.login.email.value;
		var password = document.login.password.value;

		if (email == "" || email == null) {
			alert("please enter email");
			return false;
		}

		if (password == "" || password == null) {
			alert("please enter password");
			return false;
		}
	}
</script>

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
				<div class="slogan">
					<center>
						<font color="white" size="5">Student Attendance Management
							System</font>
					</center>
				</div>
			</div>
		</div>
		
		<div id="site_content">

			<div id="content">
				<!-- insert the page content here -->

				<%
					String stauts = request.getParameter("status");

					if (stauts != null) {
				%>
				<h3><%=stauts%></h3>
				<%
					} else {
				%>
				<h3>Login Here</h3>
				<%
					}
				%>

				<form name="login" action="Login">
				
					<div class="form_settings">
						<p>
							<span>User ID</span><input class="contact" type="text"
								name="email" />
						</p>
						<p>
							<span>Password</span><input class="contact" type="text"
								name="password" />
						</p>

						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								value="Login" onclick="return validate()" />
						</p>

					</div>
					
				</form>

			</div>
		</div>
	</div>
</body>
</html>