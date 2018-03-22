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
<title>Edit Customer Information</title>
</head>
<body>
	<%
		String username = (String) session.getAttribute("username");
		String ssn = request.getParameter("ssn");
		if (ssn == null || "".equals(ssn)) {
			ssn = (String) session.getAttribute("ssn");
		}
		String firstname = "";
		String lastname = "";
		String address = "";
		String city = "";
		String state = "";
		String zipcode = "";
		String phone = "";
		String credit = "";
		
		// Check if the username exists
		System.out.println("edit customer info, ssn=" + ssn);
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

			// Get email to fill up the form
			String query = "SELECT * FROM Customers c WHERE c.ssn='" + ssn + "';";
			System.out.println(query);
			ResultSet result = stmt.executeQuery(query);
			if (result.next()) {
				firstname = result.getString("firstname");
				lastname = result.getString("lastname");
				address = result.getString("address");
				city = result.getString("city");
				state = result.getString("state");
				zipcode = result.getString("zipcode");
				phone = result.getString("phone");
				credit = result.getString("credit_card_num");
			}
			%>
			<script type="text/javascript">
				$(document).ready(function() {
					$("#inputSSN").attr('readonly', true);
				})
			</script>
			<%
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
	<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="adminHomePage.jsp">Dashboard</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-2">
			<ul class="nav navbar-nav">
				<li><a href="myCustomers.jsp">My Customers </a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">Sales<span
						class="caret"></span></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="sales/salesReport.jsp">Sales Report</a></li>
						<li><a href="sales/revenue.jsp">Revenue</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="true">Statistics
						<span class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="flightStatistics/reservations.jsp">Reservations</a></li>
						<li><a href="flightStatistics/flights.jsp">Flights</a></li>
					</ul></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li><a href="../login.jsp">Sign out</a></li>
			</ul>
		</div>
	</div>
	</nav>
	<div class="container container-padding">
		<h3>Customer Information</h3>
		<hr>
			<div class="well">
				<form class="form-horizontal" action="resetCustomerProfile.jsp">
					<fieldset>
						<legend>Profile</legend>
						<div class="form-group">
							<label for="inputFirst" class="col-lg-2 control-label">First
								name</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" name="inputFirst" value="<%=firstname %>"
									placeholder="First name">
							</div>
							<label for="inputLast" class="col-lg-2 control-label">Last
								name</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" name="inputLast" value="<%=lastname %>"
									placeholder="Last name">
							</div>
						</div>
						<div class="form-group">
							<label for="inputSSN" class="col-lg-2 control-label">Social
								Security Number</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" id="inputSSN" name="inputSSN" value="<%=ssn %>"
									placeholder="xxx-xx-xxxx">
							</div>
							<div class="col-lg-4">
										<p class="text-warning">You are not able to modify SSN.</p>
							</div>
						</div>
						<hr>
						<div class="form-group">
							<label for="inputAddress" class="col-lg-2 control-label">Address</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" name="inputAddress" value="<%=address %>"
									placeholder="Address">
							</div>
						</div>
						<div class="form-group">
							<label for="inputCity" class="col-lg-2 control-label">City</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" name="inputCity" value="<%=city %>"
									placeholder="City">
							</div>
							<label for="inputState" class="col-lg-2 control-label">State</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" name="inputState" value="<%=state %>"
									placeholder="State">
							</div>
						</div>
						<div class="form-group">
							<label for="inputZip" class="col-lg-2 control-label">Zip
								code</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" name="inputZip" value="<%=zipcode %>"
									placeholder="Zip code">
							</div>
							<label for="inputPhone" class="col-lg-2 control-label">Phone</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" name="inputPhone" value="<%=phone %>"
									placeholder="Phone number">
							</div>
						</div>
						<hr>
						<div class="form-group">
							<label for="inputCredit" class="col-lg-2 control-label">Credit
								Card Number</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" name="inputCredit" value="<%=credit %>"
									placeholder="xxxx-xxxx-xxxx-xxxx">
							</div>
						</div>
						<br>
						<div class="form-group">
							<div class="col-lg-10 col-lg-offset-2">
								<button type="submit" class="btn btn-primary">Modify profile</button>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
</body>
</html>