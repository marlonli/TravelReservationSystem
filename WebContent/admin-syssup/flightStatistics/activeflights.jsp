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
<title>Active Flights</title>
</head>
<body>
	<%
		String username = (String) session.getAttribute("username");
		System.out.println("username " + username);
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
						<li><a href="../sales/salesReport.jsp">Sales Report</a></li>
						<li><a href="../sales/revenue.jsp">Revenue</a></li>
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
		<h2>Active Flights</h2>
		<hr>
		<div class="col-lg-3">
			<div class="list-group">
				<a href="flights.jsp" class="list-group-item">All flights</a> 
				<a href="activeflights.jsp" class="list-group-item active">Active flights</a> 
				<a href="byairport.jsp"class="list-group-item">Find flights by airport</a> 
				<a href="flightstatus.jsp"class="list-group-item">Flight status</a>
			</div>
		</div>
        <div class='col-lg-9'>
		<%
			//Create a connection string
			String hostname = "cs539-spring2018.cmvm3ydsfzmo.us-west-2.rds.amazonaws.com";
			String port = "3306";
			String dbName = "cs539proj1";
			String userName = "marlonli";
			String pswd = "123123123";
			String url = "jdbc:mysql://" + hostname + ":" + port + "/" + dbName;
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
			
			//Run the query against the database.

		
			
			try {
				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, userName, pswd);
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				//Make a SELECT query from the table Reservation
				String str = "SELECT F.airline_id, L.flight_num,  Count(*) num_flight From Legs L, Flight F WHERE F.flight_num=L.flight_num Group by  L.flight_num ORDER BY COUNT(F.flight_num) DESC, F.flight_num";
				//Run the query against the database.
				
				ResultSet result = stmt.executeQuery(str);
				// #####################################
				//Make an HTML table to show the results in:
				//out.print("<form action='editCustomerInfo.jsp' id='form-customers'>");
				
				//String test = "SELECT * FROM Reservations r ";
				//ResultSet rs = stmt.executeQuery(test);
				//######################
				   //ResultSetMetaData rsmd = str.getMetaData();
				   //System.out.println("querying "+ str);
				   //int columnsNumber = rsmd.getColumnCount();
				
				out.print("<table class='table table-hover' id='table-Revenue'>");
				out.print("<thead>");
				out.print("<tr>");
				//make a column
				out.print("<th>Airline</th>");
				out.print("<th>Flight Number</th>");
				out.print("<th>Number of Flights</th>");
				
				out.print("</tr>");
				out.print("</thead>");
				
				int rowNbr = 0;
				//parse out the results
				out.print("<tbody>");
			
				while (result.next()) {
					//make a row
					//out.print("<tr>");
					out.print("<td>");
					rowNbr++;
					out.print(result.getString("F.airline_id"));
					out.print("</td>");

					//out.print("<td>");
					//out.print(result.getString("username"));
					//out.print("</td>");

					out.print("<td>");
					out.print(result.getString("L.flight_num"));
					out.print("</td>");

					out.print("<td>");
					out.print(result.getString("num_flight"));
					out.print("</td>");
				
					
					//make a row
					out.print("</tr>");
					
					//String columnValue = rs.getString(rowNbr);
					//out.print(columnValue + " ");
			
		

				}
				out.print("</tbody>");
				out.print("</table>");
				//out.print("</form>");
				//close the connection.
				con.close();

			} catch (Exception e) {
			}
		%>
</div>
</div>
</body>
</html>