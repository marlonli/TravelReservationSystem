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
<title>Reservations</title>
</head>
<body>
	<%
		String username = (String) session.getAttribute("username");
	    String flight_num = request.getParameter("flight_num");
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
		<h2>Reservations</h2>
		<form class="form-horizontal">
		<fieldset>
		<div class="form-group">
	      <label for="inputFlight" class="col-lg-2 control-label">Flight number</label>
	      <div class="col-lg-2">
	        <input type="text" class="form-control" id="inputFlight" placeholder="Flight number">
	      </div>
	      <a href="#" class="btn btn-default" id='search'>Search</a>
	    </div>
	    </fieldset>
	    </form>
		<hr>
		<div class="col-lg-3">
			<div class="list-group">
				<a href="reservations.jsp" class="list-group-item active">By flight number</a> 
				<a href="customername.jsp" class="list-group-item">By customer name</a> 
				<a href="Customershaveseats.jsp" class="list-group-item">Customers have seats</a>
			</div>
		</div>

		<div class="col-lg-9">
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
			
			try {
				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, userName, pswd);
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				//Make a SELECT query from the table Reservation
				
				String flightnumber = "SELECT l.flight_num, l.dept_date, r.date, r.username, c.firstname, c.lastname, r.total_fare FROM Legs l, Reservations r, Customers c, Own o where r.id = l.rid and r.username= o.username  and o.ssn= c.ssn and l.flight_num ="+ flight_num;
				
				//Run the query against the database.				
				ResultSet result = stmt.executeQuery(flightnumber);
				// #####################################
				//Make an HTML table to show the results in:
				//out.print("<form action='editCustomerInfo.jsp' id='form-customers'>");
				
				//String test = "SELECT * FROM Reservations r ";
				//ResultSet rs = stmt.executeQuery(test);
				//######################
				   //ResultSetMetaData rsmd = str.getMetaData();
				   //System.out.println("querying "+ str);
				   //int columnsNumber = rsmd.getColumnCount();
				
				   ///out.print("<h3>result.getString("Airline")</h3>");
				out.print("<table class='table table-hover' id='table-reservations'>");
				out.print("<thead>");
				out.print("<tr>");
				//make a column
				out.print("<th>Flight Number</th>");
				out.print("<th>Reservation Date</th>");
				out.print("<th>Departure Date</th>");
				out.print("<th>Reservation Username</th>");
				out.print("<th>First Name</th>");
				out.print("<th>Last Name</th>");
				out.print("<th>Total Fare</th>");
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
					out.print(result.getString("flight_num"));
					out.print("</td>");

					//out.print("<td>");
					//out.print(result.getString("username"));
					//out.print("</td>");

					out.print("<td>");
					out.print(result.getString("r.date"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("l.dept_date"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("r.username"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("c.firstname"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("c.lastname"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("r.total_fare"));
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
				System.out.println(e);
			}
		%>
</div>
</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
	// get current URL path and assign 'active' class
	var pathname = window.location.pathname;
	path = pathname.substr(pathname.lastIndexOf('/') + 1);
	$('.nav:first > li > a[href="' + path + '"]').parent().addClass('active');
	
	//Select a month
	$( "#search" ).click(function() {
		  $(location).attr('href','reservations.jsp?flight_num=' + $('#inputFlight').val());
		});
})
</script>
</html>		