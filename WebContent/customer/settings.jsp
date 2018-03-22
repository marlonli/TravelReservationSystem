<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<title>Settings</title>
</head>
<body>
<%
		String username = (String) session.getAttribute("username");
		String password = "";
		String preferences = "";
		
		// Check if the username exists
		System.out.println("settings, username=" + username);
		if (username == null || "".equals(username)) {
			%>
			<script type="text/javascript">
				alert("Session expired, please login first");
				window.location.href = "../login.jsp";
			</script>
			<%
		}
		
		// Create a connection string
		String hostname = "cs539-spring2018.cmvm3ydsfzmo.us-west-2.rds.amazonaws.com";
		String port = "3306";
		String dbName = "cs539proj1";
		String userName = "marlonli";
		String pswd = "123123123";
		String url = "jdbc:mysql://" + hostname + ":" + port + "/" + dbName;
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		// Update HTML content
		try {
			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, userName, pswd);

			//Create a SQL statement
			Statement stmt = con.createStatement();

			// Get password to fill up the form
			String query = "SELECT password FROM Accounts WHERE username='" + username + "';";
			System.out.println(query);
			ResultSet result = stmt.executeQuery(query);
			if (result.next()) {
				password = result.getString("password");
				System.out.println(username + " get password " + password);
			}

			// Check if the user has ssn
			String checkSSN = "SELECT c.ssn FROM Customers c JOIN Own o USING (ssn) WHERE o.username='" + username + "'";
			System.out.println(checkSSN);

			ResultSet check = stmt.executeQuery(checkSSN);
			if (!check.next()) {
				%>
				<script type="text/javascript">
					alert("Please update your profile first!");
					window.location.href = "myAccount.jsp";
				</script>
				<%
			}
			con.close();
		} catch (Exception ex) {
			System.out.println(ex);
			%>
			<!-- if error, show the alert and go back to login page -->
			<script>
				alert("Sorry, something went wrong on our server, failed to create your account");
				window.location.href = "../login.jsp?signup";
			</script>
			<%
				return;
		}
	%>
	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<div class="navbar-header active">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="customerHomePage.jsp">Home <span
				class="sr-only">(current)</span></a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-2">
			<ul class="nav navbar-nav">
				<li><a href="myReservations.jsp">My Reservations</a></li>
				<li><a href="myAccount.jsp">My Account</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li><a href="../login.jsp">Sign out</a></li>
			</ul>
		</div>
	</div>
	</nav>
	
	<div class="container ontainer-padding">
		<h3>Settings</h3>
		<hr>
		<div class="col-lg-3">
			<div class="list-group" id="group-button">
				<a href="myAccount.jsp" class="list-group-item">My profile</a> 
				<a href="settings.jsp" class="list-group-item">Settings</a>
			</div>
		</div>
		<div class="col-lg-9">
			<div class="well">
				<form class="form-horizontal" action="resetPassword.jsp">
					<fieldset>
						<legend>Password</legend>
						<div class="form-group">
							<label for="inputPassword1" class="col-lg-2 control-label">Password</label>
							<div class="col-lg-4">
								<input type="password" class="form-control" name="inputPassword1" value="<%=password%>">
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword2" class="col-lg-2 control-label">Password</label>
							<div class="col-lg-4">
								<input type="password" class="form-control" name="inputPassword2" value="<%=password%>">
							</div>
						</div>
						<br>
						<div class="form-group">
							<div class="col-lg-10 col-lg-offset-2">
								<button type="submit" class="btn btn-primary">Reset password</button>
							</div>
						</div>
					</fieldset>
				</form>
				<hr>
				<form class="form-horizontal" action="setPreferences.jsp">
					<fieldset>
						<legend>Preferences</legend>
						<div class="form-group">
							<label for="inputFirst" class="col-lg-2 control-label">First
								name</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" name="inputFirst" value="<%=username %>"
									placeholder="First name">
							</div>
							<label for="inputLast" class="col-lg-2 control-label">Last
								name</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" name="inputLast" value="<%=username %>"
									placeholder="Last name">
							</div>
						</div>
					
						<div class="form-group">
							<label for="inputAddress" class="col-lg-2 control-label">Address</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" name="inputAddress" 
									placeholder="Address">
							</div>
						</div>
						<div class="form-group">
							<label for="inputCity" class="col-lg-2 control-label">City</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" name="inputCity" 
									placeholder="City">
							</div>
							<label for="inputState" class="col-lg-2 control-label">State</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" name="inputState" 
									placeholder="State">
							</div>
						</div>
						<hr>
						<div class="form-group">
							<label for="inputCredit" class="col-lg-2 control-label">Credit
								Card Number</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" name="inputCredit" 
									placeholder="xxxx-xxxx-xxxx-xxxx">
							</div>
						</div>
						<br>
						<div class="form-group">
							<div class="col-lg-10 col-lg-offset-2">
								<button type="submit" class="btn btn-primary">Update my preferences</button>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(
				function() {
					// get current URL path and assign 'active' class
					var pathname = window.location.pathname;
					path = pathname.substr(pathname.lastIndexOf('/') + 1);
					$('.nav:first > li > a[href="' + path + '"]').parent().addClass('active');
					$('#group-button > a[href="' + path + '"]').addClass('active');
				})
	</script>
</body>
</html>