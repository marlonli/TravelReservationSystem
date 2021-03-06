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
<link rel="stylesheet" type="text/css"
	href="../../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../../css/main.css">
<title>Sales Report</title>
</head>
<body>
	<%
		String username = (String) session.getAttribute("username");
		String month = request.getParameter("month");
		System.out.print("month " + month);
		System.out.println("salesreport " + username);
		if (username == null || "".equals(username)) {
	%>
	<script type="text/javascript">
		alert("Session expired, please login first");
		window.location.href = "../asLogin.jsp";
	</script>
	<%
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
			<a class="navbar-brand" href="../adminHomePage.jsp">Dashboard</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-2">
			<ul class="nav navbar-nav">
				<li><a href="../myCustomers.jsp">My Customers </a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">Sales<span
						class="caret"></span></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="salesReport.jsp">Sales Report</a></li>
						<li><a href="revenue.jsp">Revenue</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="true">Statistics
						<span class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="../flightStatistics/reservations.jsp">Reservations</a></li>
						<li><a href="../flightStatistics/flights.jsp">Flights</a></li>
					</ul></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li><a href="../../login.jsp">Sign out</a></li>
			</ul>
		</div>
	</div>
	</nav>
	<div class="container container-padding">
		<h3>Monthly Report &nbsp 
		<%
			if (month != null && !"".equals(month)) {
				out.print("<span class='text-info'>" + month + "</span>");
			}
		%>
		</h3>
		<div class='form-group'>
			<input type='month' id='month'>
		</div>
		<hr>
		<%
		if (month != null && !"".equals(month)) {
			//Create a connection string
			String hostname = "cs539-spring2018.cmvm3ydsfzmo.us-west-2.rds.amazonaws.com";
			String port = "3306";
			String dbName = "cs539proj1";
			String userName = "marlonli";
			String pswd = "123123123";
			String url = "jdbc:mysql://" + hostname + ":" + port + "/" + dbName;
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
			try {
				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, userName, pswd);

				//Create a SQL statement
				Statement stmt = con.createStatement();

				//Make a SELECT query from the table Customers

				String str = "SELECT  r.id as reservation_id, r.date, r.username, c.firstname, c.lastname, r.total_fare FROM Reservations r JOIN Own o USING (username) JOIN Customers c USING (ssn) where date like '" + month + "-_%_'";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);

				//Make an HTML table to show the results in:
				//out.print("<form action='editCustomerInfo.jsp' id='form-customers'>");
				out.print("<table class='table table-hover' id='table-mycustomers'>");
				out.print("<thead>");
				out.print("<tr>");
				//make a column
				//out.print("<th>Account name</th>");

				out.print("<th>Date</th>");
				out.print("<th>Username</th>");
				out.print("<th>First name</th>");
				out.print("<th>Last name</th>");
				out.print("<th>Total fare</th>");
				out.print("</th>");
				
				out.print("</tr>");
				out.print("</thead>");

				//parse out the results
				out.print("<tbody>");
				while (result.next()) {
					//make a row
					//out.print("<tr>");
					out.print("<tr>");
					out.print("<td>");
					out.print(result.getString("date"));
					out.print("</td>");

					//out.print("<td>");
					//out.print(result.getString("username"));
					//out.print("</td>");

					out.print("<td>");
					out.print(result.getString("username"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("firstname"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("lastname"));
					out.print("</td>");

					out.print("<td>");
					out.print(String.format("%.2f", Float.parseFloat(result.getString("total_fare"))));
					out.print("</td>");

					//out.print("<td><input class='delete-button' type='button' value='delete' onclick='submitter("+ result.getString("ad_id") + ", 1)'/></td>");
					//out.print("<td><input class='report-button' type='button' value='get-report' onclick='submitter("+ result.getString("ad_id") + ", 2)'/></td>");

					out.print("</tr>");

				}
				out.print("</tbody>");
				out.print("</table>");
				out.print("</form>");
				//close the connection.
				con.close();

			} catch (Exception e) {
				System.out.println(e);
			}
		}
		%>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		// get current URL path and assign 'active' class
		var pathname = window.location.pathname;
		path = pathname.substr(pathname.lastIndexOf('/') + 1);
		$('.nav:first > li > a[href="' + path + '"]').parent().addClass('active');
	
		// Select a month
		$( "#month" ).change(function() {
			  $(location).attr('href','salesReport.jsp?month=' + $('#month').val());
			});
	
	})
</script>
</html>