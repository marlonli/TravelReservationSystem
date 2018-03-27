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
<title>Review Flight</title>
</head>
<body>
<%
	String username = (String) session.getAttribute("username");
	System.out.println("search return flight, username=" + username);
	String flightNum1 = request.getParameter("flight_num1");
	String flightNum2 = request.getParameter("flight_num2");
	String from = request.getParameter("from");
	String to = request.getParameter("to");
	String from2 = request.getParameter("from2");
	String to2 = request.getParameter("to2");
	String dept_date1 = request.getParameter("dept_date1");
	String dept_time1 = request.getParameter("dept_time1");
	String arvl_time1 = request.getParameter("arvl_time1");
	String dept_date2 = request.getParameter("dept_date2");
	String dept_time2 = request.getParameter("dept_time2");
	String arvl_time2 = request.getParameter("arvl_time2");
	String adults = request.getParameter("adults");
	String children = request.getParameter("children");
	String price1 = request.getParameter("price1");
	String price2 = request.getParameter("price2") == null ? "0.0" : request.getParameter("price2");
	Float totalPrice;
	
	if (username == null) {
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
				<li><a href="myAccount.jsp">My Account</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li><a href="../login.jsp">Sign out</a></li>
			</ul>
		</div>
	</div>
	</nav>
  <div class="container container-padding">
	<h3>Review your selection</h3>
	<hr>
	<div class="panel panel-default">
  		<div class="panel-body">
   		 <h4><strong><%=dept_date1 %></strong></h4>
   		 <h4><%=flightNum1 %></h4>
   		 <h3><%=dept_time1%> &nbsp <strong><%=from %></strong>&nbsp to &nbsp <%=arvl_time1 %> &nbsp <strong><%=to %></strong></h3>
   		 <h4 class='text-info'><%=price1 %></h4>
  		</div>
  	</div>
  	<%
  	if (flightNum2 != null && !"".equals(flightNum2)) {
  		out.print("<div class='panel panel-default'>");
  		out.print("<div class='panel-body'>");
  		out.print("<h4><strong>" + dept_date2 + "</strong></h4>");
  		out.print("<h4>" + flightNum2 + "</h4>");
  		if (from2 != null && !"".equals(from2)) {
  	  		out.print("<h3>" + dept_time2 + "&nbsp <strong>" + from2 + "</strong> &nbsp to &nbsp " + arvl_time2 + "&nbsp <strong>" + to2 + "</strong></h3>");
  		} else {
  			out.print("<h3>" + dept_time2 + "&nbsp <strong>" + to + "</strong> &nbsp to &nbsp " + arvl_time2 + "&nbsp <strong>" + from + "</strong></h3>");
  		}
  		out.print("<h4 class='text-info'>" + price2 + "</h4>");
  		out.print("</div></div>");
  	}
  	%>
  	<p><a href="customerHomePage.jsp"><< Change flights</a></p>
  	<div class='well'>
  		<%Float total =  Float.valueOf(price1.substring(1)) + Float.valueOf(price2.substring(1));
  		totalPrice = total * (Integer.valueOf(adults)) + total / 2 * (Integer.valueOf(children));
  		Float booking = totalPrice * 0.0065f;
  		totalPrice += booking;%>
  		<h3><%=adults %> adults: <span class='text-info'>$<%= String.format("%.2f",total)%></span> &nbsp&nbsp <%=children %> children: <span class='text-info'>$<%= String.format("%.2f",total / 2)%></span></h3>
  	  	<h3>Booking fee: <span class='text-info'>$<%=String.format("%.2f",booking) %></span></h3>
  	  	<h3>Trip total: <span class='text-info'>$<%=String.format("%.2f",totalPrice) %></span></h3>
  	</div>
  	<h3>Select seats</h3>
  	<hr>
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

		//Make a SELECT query to get the available seats
		String str = "SELECT seat_num FROM Legs WHERE flight_num = " + flightNum1.split(" ")[1] + " AND pid IS NULL;";
		System.out.println(str);
		
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		
		List<String> seats = new ArrayList<>();
		while (result.next()) {
			seats.add(result.getString("seat_num"));
		}
  	    
		// Print out the seat selection panel of the first flight
		out.print("<div class='panel panel-default'>");
  		out.print("<div class='panel-body'>");
  		out.print("<h4><strong>" + dept_date1 + "</strong></h4>");
  		out.print("<h4>" + flightNum1 + "</h4>");
  		out.print("<div class='well'>");
  		out.print("<form class='form-horizontal'>");
  		out.print("<fieldset>");
  		
  		for (int i = 1; i <= Integer.valueOf(adults) + Integer.valueOf(children); i++) {
  			out.print("<legend>Traveler" + i + "</legend>");
  			out.print("<div class='form-group'>");
  			out.print("<label for='inputFirst" + i + "' class='col-lg-2 control-label'>First name</label>");
  			out.print("<div class='col-lg-2'>");
  			out.print("<input type='text' class='form-control' id='inputFirst" + i + "' name='inputFirst" + i + "' placeholder='First name'>");
  	      	out.print("</div>");
  	      	out.print("<label for='inputLast" + i + "' class='col-lg-2 control-label'>Last name</label>");
  	      	out.print("<div class='col-lg-2'>");
  	      	out.print("<input type='text' class='form-control' id='inputLast" + i + "' name='inputLast" + i + "' placeholder='Last name'>");
  	      	out.print("</div>");
  	      	out.print("<label for='inputSeat" + i + "1' class='col-lg-2 control-label'>Seat</label>");
  	      	out.print("<div class='col-lg-2'><select class='form-control' id='seat" + i + "1' name='seat" + i + "1'>");
  	      	for (String seat : seats) {
  	      		out.print("<option>" + seat + "</option>");
  	      	}
  	      			
  	      	out.print("</select>");
  	      	out.print("</div>");
  	    		out.print("</div>");
  		}
  		out.print("</fieldset></form></div></div></div>");
  		
  		// if the second flight exists, print out seat selection
  		if (flightNum2 != null && !"".equals(flightNum2)) {
  			//Make a SELECT query to get the available seats
  			str = "SELECT seat_num FROM Legs WHERE flight_num = " + flightNum2.split(" ")[1] + " AND pid IS NULL;";
  			
  			//Run the query against the database.
  			result = stmt.executeQuery(str);
  			
  			seats.clear();
  			while (result.next()) {
  				seats.add(result.getString("seat_num"));
  			}
  		
  			out.print("<div class='panel panel-default'>");
  	  		out.print("<div class='panel-body'>");
  	  		out.print("<h4><strong>" + dept_date2 + "</strong></h4>");
  	  		out.print("<h4>" + flightNum2 + "</h4>");
	  	  	out.print("<div class='well'>");
	  		out.print("<form class='form-horizontal'>");
	  		out.print("<fieldset>");
  			
	  	  	for (int i = 1; i <= Integer.valueOf(adults) + Integer.valueOf(children); i++) {
	  	  		out.print("<legend>Traveler" + i + "</legend>");
	  			out.print("<div class='form-group'>");
	  	      	out.print("<label for='inputSeat" + i + "2' class='col-lg-2 control-label'>Seat</label>");
	  	      	out.print("<div class='col-lg-2'><select class='form-control' id='seat" + i + "2' name='seat" + i + "2'>");
	  	      	for (String seat : seats) {
	  	      		out.print("<option>" + seat + "</option>");
	  	      	}
	  	      			
	  	      	out.print("</select>");
	  	      	out.print("</div>");
	  	    		out.print("</div>");
	  		}
  		out.print("</field></form></div></div></div>");
  		}
  		con.close();
	} catch (Exception e) {
		System.out.println(e);
	}
  	%>
  	<a id='continue' class='btn btn-info'>Continue to pay</a>
  </div>
</body>
<script>
$(document).ready(function() {
		// button click function
		$('#continue').click(function() {
			var numTraveler = parseInt(<%=adults%>) + parseInt(<%=children%>);
			var seats = "";
			var names = "";
			// Encoding seats
			for (var i = 1; i <= numTraveler; i++) {
				names += $('#inputFirst' + i).val();
				names += " ";
				names += $('#inputLast' + i).val();
				names += " ";
				seats += $('#seat' + i + '1').val();
				seats += " ";
				seats += $('#seat' + i + '2').val();
				seats += " ";
			}
			console.log("clicked");
			$(location).attr('href', "newReservation.jsp?flight_num1=<%=flightNum1%>&flight_num2=<%=flightNum2%>&num_traveler=" + numTraveler + "&names=" 
					+ names + "&seats=" + seats + "&price=<%=totalPrice%>&booking=<%=booking%>");
		});
	})
</script>
</html>