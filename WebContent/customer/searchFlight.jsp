<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
<title>Search For Flights</title>
</head>
<body>
<%
	int search = 0; // 0: round trip, 1: one way, 2: multi-city
	String username = (String) session.getAttribute("username");
	System.out.println("search flight, username=" + username);
	String flightNum = "";
	String airline = "";
	String from = request.getParameter("inputOrigin");
	String fromCountry = "";
	String to = request.getParameter("inputDestination");
	String toCountry = "";
	String from2 = request.getParameter("inputOrigin2");
	String from2Country = "";
	String to2 = request.getParameter("inputDestination2");
	String to2Country = "";
	String dept_date = request.getParameter("inputDeparting");
	String dept_date2 = request.getParameter("inputDeparting2");
	String return_date = request.getParameter("inputReturning");
	System.out.println(from2);
	if (from2 != null && !"".equals(from2)) {
		search = 2;
	} else if (return_date != null && !"".equals(return_date)) {
		search = 0;
	} else {
		search = 1;
	}
	session.setAttribute("searchType", search);
	System.out.println(dept_date);
	String adults = request.getParameter("adults");
	String children = request.getParameter("children");
	String dept_time = "";
	String arvl_time = "";
	String price = "";
	String duration = "";
	String working_days = "";
	String domOrInt = ""; // Domestic or international
	if (username == null) {
	%>
	<script type="text/javascript">
		alert("Session expired, please login first");
		window.location.href = "../login.jsp";
	</script>
	<%
	} 
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
		
		// Get the country of the airport
		String getCountry = "SELECT a.country FROM Airport a WHERE a.id='" + from + "'";
		System.out.println(getCountry);
		ResultSet rs = stmt.executeQuery(getCountry);
		if (rs.next()) {
			fromCountry = rs.getString("country");
		}
		getCountry = "SELECT a.country FROM Airport a WHERE a.id='" + to + "'";
		System.out.println(getCountry);
		rs = stmt.executeQuery(getCountry);
		if (rs.next()) {
			toCountry = rs.getString("country");
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
				<li><a href="reservations.jsp">My Reservations</a></li>
				<li><a href="searchFlight.jsp">Search Flight</a></li>
				<li><a href="myAccount.jsp">My Account</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li><a href="../login.jsp">Sign out</a></li>
			</ul>
		</div>
	</div>
	</nav>
	<div class="container container-padding">
		<h3>Search for a flight <span class='text-info'><%=domOrInt %></span></h3>
		<hr>
		<% 
				//Make a SELECT query
				String str = "SELECT f.working_days, sec_to_time(max(time_to_sec(s.dept_time))) dept_time," + 
					"sec_to_time(max(time_to_sec(s.arvl_time))) arvl_time, f.airline_id, l.flight_num, l.price FROM Legs l JOIN Flight f USING (flight_num) JOIN Has h USING (flight_num)JOIN Stops s ON h.stop_id=s.id WHERE l.dept_date='" 
				+ dept_date + "' AND l.from_arpt='" + from + "' AND l.to_arpt='" + to + "' AND l.pid IS NULL GROUP BY (f.flight_num);";
				System.out.println(str);
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);

				//Make an HTML table to show the results in:
				//out.print("<form action='editCustomerInfo.jsp' id='form-customers'>");
				out.print("<table class='table table-hover' id='table-flights'>");
				out.print("<thead>");
				out.print("<tr>");
				//make a column
				out.print("<th>Flight</th>");
				out.print("<th>From</th>");
				out.print("<th>Departure</th>");
				out.print("<th>To</th>");
				out.print("<th>Arrival</th>");
				out.print("<th>Duration</th>");
				out.print("<th>Price</th>");
				out.print("<th></th>");
				out.print("</th>");
				out.print("</tr>");
				out.print("</thead>");

				//parse out the results
				int rowNbr = 0;
				out.print("<tbody>");
				while (result.next()) {
					//make a row
					//out.print("<tr>");
					out.print("<tr class='clickable-row' id='" + result.getString("airline_id") + " " + result.getString("flight_num") + "'>");
					rowNbr++;
					out.print("<td>");
					out.print(result.getString("airline_id") + " " + result.getString("flight_num"));
					out.print("</td>");

					out.print("<td>");
					out.print(from);
					out.print("</td>");
					
					dept_time = result.getString("dept_time");
					String[] dept = dept_time.split(":");
					out.print("<td id='dept-time'>");
					out.print(dept[0] + ":" + dept[1]);
					out.print("</td>");

					out.print("<td>");
					out.print(to);
					out.print("</td>");
					
					arvl_time = result.getString("arvl_time");
					String[] arvl = arvl_time.split(":");
					out.print("<td id='arvl-time'>");
					out.print(arvl[0] + ":" + arvl[1]);
					out.print("</td>");

					SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
					java.util.Date date1 = format.parse(dept_time);
					java.util.Date date2 = format.parse(arvl_time);
					long difference = date2.getTime() - date1.getTime();
					long hour = (difference / (60 * 60 * 1000));
				    long min = ((difference / (60 * 1000)) - hour * 60);
					out.print("<td>");
					if (hour != 0) {
						out.print(hour + "h " + min + "m");
					} else {
						out.print(min + "m");
					}
					out.print("</td>");
					
					out.print("<td id='price'>");
					out.print("$" + result.getString("price"));
					out.print("</td>");
					
					out.print("<td>");
					out.print("<Button class='btn btn-default'>SELECT</Button>");
					out.print("</td>");

					out.print("</tr>");

				}
				out.print("</tbody>");
				out.print("</table>");
				out.print("</form>");
				if (rowNbr == 0) {
					out.print("<div class='alert alert-dismissible alert-danger'>");
					out.print("<button type='button' class='close' data-dismiss='alert'>&times;</button>");
					out.print("Sorry, no flight available yet.</div>");
				}
				//close the connection.
				con.close();

			} catch (Exception e) {
				System.out.println(e);
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
		// "select" button click function
		$('#table-flights tbody td button').click(function() {
			var flight_num = $(this).parent().parent().attr('id');
			var dept_time = $(this).parent().parent().find('#dept-time').html();
			var arvl_time = $(this).parent().parent().find('#arvl-time').html();
			var price = $(this).parent().parent().find('#price').html();
			<% 
			System.out.println("searchType" + session.getAttribute("searchType"));
			if ((Integer) session.getAttribute("searchType") == 0) {%>
				// round trip
				$(location).attr('href','searchReturnFlight.jsp?flight_num='+ flight_num + "&return="
				+ "<%=return_date%>&dept=<%=dept_date%>&from=<%=to%>&to=<%=from%>&adults=<%=adults%>&children=<%=children%>" 
				+ "&dept_time1=" + dept_time + "&arvl_time1=" + arvl_time + "&price=" + price);
			<%} else if ((Integer) session.getAttribute("searchType") == 1) {%>
				// one way
				$(location).attr("href","reviewFlight.jsp?flight_num1="+ flight_num + "&dept_date1=<%=dept_date%>&from=<%=from%>&to=<%=to%>&adults=<%=adults%>&children=<%=children%>" 
						+ "&dept_time1=" + dept_time + "&arvl_time1=" + arvl_time + "&price1=" + price);
			<%} else {%>
				$(location).attr('href','searchMulticity.jsp?flight_num='+ flight_num + "&dept2="
				+ "<%=dept_date2%>&dept=<%=dept_date%>&from=<%=from%>&to=<%=to%>&from2=<%=from2%>&to2=<%=to2%>&adults=<%=adults%>&children=<%=children%>" 
				+ "&dept_time1=" + dept_time + "&arvl_time1=" + arvl_time + "&price=" + price);
			<%}
			%>
		});
	})
</script>
</html>