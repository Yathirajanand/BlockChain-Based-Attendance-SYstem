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

		var oldpassword = document.passwordchange.oldpassword.value;
		var newpassword = document.passwordchange.newpassword.value;

		if (oldpassword == "" || oldpassword == null) {
			alert("please enter oldpassword");
			return false;
		}

		if (newpassword == "" || newpassword == null) {
			alert("please enter newpassword");
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

					<li><a class="current" href="facultyhome.jsp">Home</a></li>
					<li class="hvr-sweep-to-bottom"><a href="logout.jsp">Logout</a></li>

				</ul>
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
				<h1>Change Password</h1>
				<%
					}
				%>

				<form name="passwordchange" action="changePassword" method="get">

					<div class="form_settings">
						<p>
							<span>OLD PASSWORD</span><input class="contact" type="text"
								name="oldpassword" />
						</p>
						<p>
							<span>New Password</span><input class="contact" type="text"
								name="newpassword" />
						</p>

						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								value="Change" onclick="return validate()" />
						</p>

					</div>
				</form>

			</div>
		</div>
		<div id="footer">
			<p></p>
		</div>
	</div>
</body>
</html>
