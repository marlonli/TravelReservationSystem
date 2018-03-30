
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Reservation History</title>
</head>
<body>
      <center>
         <h1>Display Current Date & Time</h1>
      </center>
      <%
         Date dNow = new Date( );
         SimpleDateFormat ft = 
         new SimpleDateFormat ("YYYY/MM/dd");
         out.print( "<h2 align=\"center\">" + ft.format(dNow) + "</h2>");
      %>
<%
String username = (String) session.getAttribute("username");
System.out.println("flight history, username=" + username);
  if (username == null || "".equals(username)) {
%>
<script type="text/javascript">
  alert("Session expired, please login first");
  window.location.href = "../login.jsp";
</script>
<%
  } 
  %>
<nav class="navbar navbar-default navbar-fixed-top">
	  <div class="container">
	    <div class="navbar-header active">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="customerHomePage.jsp">Home <span class="sr-only">(current)</span></a>
	    </div>
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
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
<div class="container container-padding">
<h3>My Reservations</h3>
<hr>
<div class="col-lg-3">
   <div class="list-group">
 	  <a href="#" class="list-group-item active">Current reservations</a>
 	  <a href="#" class="list-group-item">Reservation history</a>
   </div>
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

	//Make a SELECT query from the table Customers
	String str = "SELECT     a.username,    r.id rid,    r.date,    r.booking_fee,	    r.total_fare,    l.dept_date,	    MAX(s.dept_time) dept_time,	    l.arvl_date,    Max(s.arvl_time) arvl_time,    f.airline_id,   l.flight_num,    l.seat_num,	    l.seat_class,l.from_arpt, ap.city from_city,  l.to_arpt, ap2.city to_city,  p.firstname,   p.lastname FROM Accounts a   JOIN Reservations r USING (username) JOIN Legs l ON (r.id = l.rid)  JOIN  Passengers p ON (l.pid = p.id)   JOIN   Flight f ON f.flight_num = l.flight_num   JOIN Airports ap ON l.from_arpt = ap.id JOIN Airports ap2 ON l.to_arpt=ap2.id JOIN Stops s ON f.flight_num=s.flight_num   WHERE a.username='" + username + "'group by r.date ;";

	//Run the query against the database.
	ResultSet result = stmt.executeQuery(str);

	
	
	
	//Make an HTML table to show the results in:
	//out.print("<form action='editCustomerInfo.jsp' id='form-myReservations'>");
	out.print("<table class='table table-hover' id='table-myReservations'>");
	out.print("<thead>");
	out.print("<tr>");
	//make a column
	out.print("<th>#</th>");
	out.print("<th>Flight Number11 </th>");
	out.print("<th>Departure City</th>");
	out.print("<th>Destination City</th>");
	out.print("<th>Departure Date</th>");
	out.print("<th>Arrival Date</th>");
	out.print("</th>");
	out.print("</tr>");
	out.print("</thead>");
	
	//parse out the results
	int rowNbr = 0;
	out.print("<tbody>");
	while (result.next()) {
		//make a row
		out.print("<tr class='clickable-row' id='" + result.getString("flight_num") + "'>");
		rowNbr++;
		out.print("<td>");
		out.print(rowNbr);
		out.print("</td>");
	
		out.print("<td>");
	out.print(result.getString("airline_id"));
	out.print(result.getString("flight_num"));
	out.print("</td>");		
	
	
	out.print("<td>");
	out.print(result.getString("from_city"));
	out.print("</td>");		
	
	
	out.print("<td>");
	out.print(result.getString("to_city"));
	out.print("</td>");		
	
	out.print("<td>");
	out.print(result.getString("dept_date"));
	out.print("</td>");		
	
	out.print("<td>");
	out.print(result.getString("arvl_date"));
	out.print("</td>");		
	
	out.print("</tr>");	
	}
	
	out.print("</tbody>");
	out.print("</table>");
	out.print("</form>");
	//close the connection.
	
	
	

	
	String str2 = "SELECT T1.airline_id ,T1.flight_num FROM (   SELECT     a.username,    r.id rid,    r.date,    r.booking_fee,	    r.total_fare,    l.dept_date,	    MAX(s.dept_time) dept_time,	    l.arvl_date,    Max(s.arvl_time) arvl_time,    f.airline_id,   l.flight_num,    l.seat_num,	    l.seat_class,l.from_arpt, ap.city from_city,  l.to_arpt, ap2.city to_city,  p.firstname,   p.lastname FROM Accounts a   JOIN Reservations r USING (username) JOIN Legs l ON (r.id = l.rid)  JOIN  Passengers p ON (l.pid = p.id)   JOIN   Flight f ON f.flight_num = l.flight_num   JOIN Airports ap ON l.from_arpt = ap.id JOIN Airports ap2 ON l.to_arpt=ap2.id JOIN Stops s ON f.flight_num=s.flight_num  group by r.date) T1 GROUP BY T1.flight_num ORDER BY COUNT(T1.flight_num) DESC, T1.flight_num LIMIT 1 ;";
	String prefix = "THE BEST SELLER =";
//Run the query against the database.
ResultSet result2 = stmt.executeQuery(str2);

out.print("<h2>Best Seller</h2>");
out.print("<thead>");
out.print("<tr>");
//make a column
out.print("<th>#</th>");
out.print("<th> </th>");

out.print("</th>");
out.print("</tr>");
out.print("</thead>");

//parse out the results
int rowNbr1 = 0;

out.print("<tbody>");

while (result2.next()) {
	

out.print("<tr>");

rowNbr1++;

out.print("<td>");
out.print(rowNbr1);
out.print("</td>");


out.print("<td>");
out.print(prefix);
out.print(result2.getString("T1.airline_id"));
out.print(result2.getString("T1.flight_num"));
//out.print(ft.format(dNow));
out.print("</td>");		


out.print("</tr>");	
out.print("</tbody>");
}



// CURRENT RESERVATION
String str3 = "SELECT * FROM ( SELECT T1.flight_num,T1.reservation_date, T1.dept_date,T1.dept_time, T1.airline_id, T1.from_city,T1.from_arpt,T1.seat_num,T1.seat_class,T1.arvl_date,T1.arvl_time,T1.to_city,T1.to_arpt FROM (   SELECT     a.username,    r.id rid,    r.date reservation_date,    r.booking_fee,	    r.total_fare,    l.dept_date,	    MAX(s.dept_time) dept_time,	    l.arvl_date,    Max(s.arvl_time) arvl_time,    f.airline_id,   l.flight_num,    l.seat_num,	    l.seat_class,l.from_arpt, ap.city from_city,  l.to_arpt, ap2.city to_city,  p.firstname,   p.lastname FROM Accounts a   JOIN Reservations r USING (username) JOIN Legs l ON (r.id = l.rid)  JOIN  Passengers p ON (l.pid = p.id)   JOIN   Flight f ON f.flight_num = l.flight_num   JOIN Airports ap ON l.from_arpt = ap.id JOIN Airports ap2 ON l.to_arpt=ap2.id JOIN Stops s ON f.flight_num=s.flight_num WHERE a.username='" + username + "'  group by r.date) T1 )T2 WHERE T2.dept_date>='" + ft.format(dNow)  + "'";
//	String prefix = "THE BEST SELLER =";
//Run the query against the database.
ResultSet result3 = stmt.executeQuery(str3);

out.print("<table class='table table-hover' id='table-myReservations'>");
out.print("<h2>Current Reservation</h2>");

out.print("<thead>");
out.print("<tr>");
//make a column
out.print("<th>#</th>");
out.print("<th>Flight Number11 </th>");
out.print("<th>Departure City</th>");
out.print("<th>Destination City</th>");
out.print("<th>Departure Date</th>");
out.print("<th>Arrival Date</th>");
out.print("</th>");
out.print("</tr>");
out.print("</thead>");

//parse out the results
	int rowNbr3 = 1;
	out.print("<tbody>");
	while (result3.next()) {
		//make a row
		
		out.print("<tr>");
		rowNbr++;
		out.print("<td>");
		out.print(rowNbr3);
		out.print("</td>");
		
		
		
	out.print("<td>");
	out.print(result3.getString("airline_id"));
	out.print(result3.getString("flight_num"));
	out.print("</td>");		
	
	
	out.print("<td>");
	out.print(result3.getString("from_city"));
	out.print("</td>");		
	
	
	out.print("<td>");
	out.print(result3.getString("to_city"));
	out.print("</td>");		
	
	out.print("<td>");
	out.print(result3.getString("dept_date"));
	out.print("</td>");		
	
	out.print("<td>");
	out.print(result3.getString("arvl_date"));
	out.print("</td>");		
	
	out.print("</tr>");	
}
	
	out.print("</tbody>");
	out.print("</table>");
	

	con.close();

} catch (Exception e) {
}
	


%>

</div>

<script type="text/javascript">
$(document).ready(function() {
	// get current URL path and assign 'active' class
	var pathname = window.location.pathname;
	path = pathname.substr(pathname.lastIndexOf('/') + 1);
	$('.nav:first > li > a[href="'+path+'"]').parent().addClass('active');
	//table row click function
	$('#table-myReservations tbody tr').click(function() {
		$(location).attr('href', 'itinerary.jsp?flight_num=' + $(this).attr('id'));
	});
})
</script>
</html>