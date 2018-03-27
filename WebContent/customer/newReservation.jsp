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
<title>Make Payment</title>
</head>
<body>
<div class="progress progress-striped active">
  	  <div class="progress-bar" style="width: 100%"></div>
</div>
<%
	String username = (String) session.getAttribute("username");
	System.out.println("payment, username=" + username);
	String flightNum1 = request.getParameter("flight_num1");
	String flightNum2 = request.getParameter("flight_num2");
	System.out.println(flightNum2);
	int numTraveler = Integer.valueOf(request.getParameter("num_traveler"));
	String names = request.getParameter("names");
	String seats = request.getParameter("seats");
	System.out.println(request.getParameter("price"));
	Float price = Float.valueOf(request.getParameter("price"));
	Float totalPrice = price;
	Float booking = Float.parseFloat(request.getParameter("booking"));
	if (username == null) {
%>
	<script type="text/javascript">
		alert("Session expired, please login first");
		window.location.href = "../login.jsp";
	</script>
	<%
  } 
	String[] nameArr = names.split(" ");
	String[] firstnames = new String[numTraveler];
	String[] lastnames = new String[numTraveler];
	String[] seat1 = new String[numTraveler];
	String[] seat2 = new String[numTraveler];
	String[] seatArr = seats.split(" ");
	for (int i = 0; i < numTraveler; i++) {
		firstnames[i] = nameArr[2 * i];
		lastnames[i] = nameArr[2 * i + 1];
		if (flightNum2 != null && !"".equals(flightNum2)) {
			seat1[i] = seatArr[2 * i];
			seat2[i] = seatArr[2 * i + 1];
		} else {
			seat1[i] = seatArr[i];
		}
	}
	for (int i = 0; i < numTraveler; i++) {
		System.out.println(firstnames[i]);
		System.out.println(lastnames[i]);
		System.out.println(seat1[i]);
		
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
		// Get date
		System.currentTimeMillis();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date currentDate = new java.util.Date(System.currentTimeMillis());
		String newDate = df.format(currentDate);
		//Make an insert statement for the Accounts table:
		String insert = "INSERT INTO Reservations (date, booking_fee, total_fare, username) VALUES(?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
		// Set insert values	
		ps.setString(1, newDate);
		ps.setDouble(2, booking);
		ps.setDouble(3, totalPrice);
		ps.setString(4, username);
		//Run the query against the database.
		ps.executeUpdate();
		ResultSet rset = ps.getGeneratedKeys();
		int rid = 0;
		if (rset.next()){
		    rid=rset.getInt(1);
		}
		String update = "";
		
		Statement stmt = con.createStatement();
		
		for (int i = 0; i < numTraveler; i++) {
			insert = "INSERT INTO Passengers (firstname, lastname) VALUES(?, ?)";
			System.out.println(insert);
			ps = con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, firstnames[i]);
			ps.setString(2, lastnames[i]);
			ps.executeUpdate();
			ResultSet rs = ps.getGeneratedKeys();
			int id = 0;
			if (rs.next()){
			    id=rs.getInt(1);
			}
			System.out.println(i);
			update = "UPDATE Legs SET rid=" + rid + ", pid=" + id + " WHERE seat_num='" + seat1[i] + "' AND flight_num=" + flightNum1.split(" ")[1];
			System.out.println(update);
			ps.executeUpdate(update);
			System.out.println(i);
			if (flightNum2 != null && !"".equals(flightNum2) && !"null".equals(flightNum2)) {
				update = "UPDATE Legs SET rid=" + rid + ", pid=" + id + " WHERE seat_num='" + seat2[i] + "' AND flight_num=" + flightNum2.split(" ")[1];
				System.out.println(update);
				ps.executeUpdate(update);
			}
			System.out.println(i);
		}
		
		out.print("<p class='lead text-success'>&nbsp&nbsp&nbsp&nbspCongratulations! You have make a new revservation.</p>");
		%>
		<script> 	    		
		    window.location.href = "myReservations.jsp";
		</script>
		<%
		con.close();
	} catch (Exception e) {
		System.out.println(e);
		%>
		<script> 
	    		alert("Sorry, something went wrong on our server");
	    		window.location.href = "customerHomePage.jsp?signup";
		</script>
		<%
	}
	
	
	
  %>
</body>
</html>