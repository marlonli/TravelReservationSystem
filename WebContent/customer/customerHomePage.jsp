<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
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
<title>Customer Home Page</title>
</head>
<body>
<%
String username = (String) session.getAttribute("username");
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
	    <div class="navbar-header">
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

<br>
<div class="container container-padding">
<div class="jumbotron">
  <h3>Hello,  ${username}</h3>
  <p>If you have not complete your profile, please go to <a href="myAccount.jsp">My Account</a> and modify your profile first.</p>
</div>
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
	
	String str2 = "SELECT T1.airline_id ,T1.flight_num FROM (   SELECT     a.username,    r.id rid,    r.date,    r.booking_fee,	    r.total_fare,    l.dept_date,	    MAX(s.dept_time) dept_time,	    l.arvl_date,    Max(s.arvl_time) arvl_time,    f.airline_id,   l.flight_num,    l.seat_num,	    l.seat_class,l.from_arpt, ap.city from_city,  l.to_arpt, ap2.city to_city,  p.firstname,   p.lastname FROM Accounts a   JOIN Reservations r USING (username) JOIN Legs l ON (r.id = l.rid)  JOIN  Passengers p ON (l.pid = p.id)   JOIN   Flight f ON f.flight_num = l.flight_num   JOIN Airports ap ON l.from_arpt = ap.id JOIN Airports ap2 ON l.to_arpt=ap2.id JOIN Stops s ON f.flight_num=s.flight_num  group by r.date) T1 GROUP BY T1.flight_num ORDER BY COUNT(T1.flight_num) DESC, T1.flight_num LIMIT 1 ;";
	String prefix = "THE BEST SELLER IS ";
	//Run the query against the database.
	ResultSet result2 = stmt.executeQuery(str2);
	
	out.print("<h3>Best Seller</h3>");
	out.print("<thead>");
	out.print("<tr>");
	
	out.print("</th>");
	out.print("</tr>");
	out.print("</thead>");
	
	//parse out the results
	int rowNbr1 = 0;
	
	out.print("<tbody>");
	
	while (result2.next()) {
		
	
	out.print("<tr>");
	
	out.print("<td>");
	out.print(prefix);
	out.print("<span class='text-success'>");
	out.print(result2.getString("T1.airline_id"));
	out.print(result2.getString("T1.flight_num"));
	out.print("</span>");
	out.print("</td>");		
	
	
	out.print("</tr>");	
	out.print("</tbody>");
	}
} catch (Exception e) {
	System.out.println(e);
}
%>
<hr>
<h3>Search a flight</h3>
<ul class="nav nav-tabs">
  <li class="active" id="round-trip"><a href="#roundtrip" data-toggle="tab" aria-expanded="false">Round trip</a></li>
  <li class="" id="one-way"><a href="#oneway" data-toggle="tab" aria-expanded="true">One way</a></li>
  <li class="" id="multi-city"><a href="#multicity" data-toggle="tab" aria-expanded="false">Multi-city</a></li>
</ul>
<div id="myTabContent" class="tab-content">
  <div class="tab-pane fade active in" id="roundtrip">
	<br>
	  <form class="form-horizontal" action=searchFlight.jsp>
	  <fieldset>
	    <div class="form-group">
	      <label for="inputOrigin" class="col-lg-2 control-label">Flying from</label>
	      <div class="col-lg-4">
	        <input type="text" class="form-control" name="inputOrigin" placeholder="Origin">
	      </div>
	      <label for="inputDestination" class="col-lg-2 control-label">Flying to</label>
	      <div class="col-lg-4">
	        <input type="text" class="form-control" name="inputDestination" placeholder="Destination">
	      </div>
	    </div>
	    <div class="form-group">
	      <label for="inputDeparting" class="col-lg-2 control-label">Departing</label>
	      <div class="col-lg-4">
	        <input type="date" class="form-control" name="inputDeparting" >
	      </div>
	      <label for="inputReturning" class="col-lg-2 control-label">Returning</label>
	      <div class="col-lg-4">
	        <input type="date" class="form-control" name="inputReturning" >
	      </div>
	    </div>
	    <div class="form-group">
	      <label for="select" class="col-lg-2 control-label">Adults (18+)</label>
	      <div class="col-lg-4">
	        <select class="form-control" name="adults">
	          <option>1</option>
	          <option>2</option>
	          <option>3</option>
	          <option>4</option>
	          <option>5</option>
	          <option>6</option>
	        </select>
	      </div>
	      <label for="select" class="col-lg-2 control-label">Children (0-17)</label>
	      <div class="col-lg-4">
	        <select class="form-control" name="children">
	          <option>0</option>
	          <option>1</option>
	          <option>2</option>
	          <option>3</option>
	          <option>4</option>
	          <option>5</option>
	          <option>6</option>
	        </select>
	      </div>
	    </div>
	    <div class="form-group">
	      <div class="col-lg-10 col-lg-offset-2">
	        <button type="reset" class="btn btn-default">reset</button>
	        <span>&nbsp&nbsp</span>
	        <button type="submit" class="btn btn-primary">Submit</button>
	      </div>
	    </div>
	  </fieldset>
	</form>
  </div>
  
  <div class="tab-pane fade" id="oneway">
	<br>
	  <form class="form-horizontal" action="searchFlight.jsp">
	  <fieldset>
	    <div class="form-group">
	      <label for="inputOrigin" class="col-lg-2 control-label">Flying from</label>
	      <div class="col-lg-4">
	        <input type="text" class="form-control" name="inputOrigin" placeholder="Origin">
	      </div>
	      <label for="inputDestination" class="col-lg-2 control-label">Flying to</label>
	      <div class="col-lg-4">
	        <input type="text" class="form-control" name="inputDestination" placeholder="Destination">
	      </div>
	    </div>
	    <div class="form-group">
	      <label for="inputDeparting" class="col-lg-2 control-label">Departing</label>
	      <div class="col-lg-4">
	        <input type="date" class="form-control" name="inputDeparting" >
	      </div>
	    </div>
	    <div class="form-group">
	      <label for="select" class="col-lg-2 control-label">Adults (18+)</label>
	      <div class="col-lg-4">
	        <select class="form-control" name="adults">
	          <option>1</option>
	          <option>2</option>
	          <option>3</option>
	          <option>4</option>
	          <option>5</option>
	          <option>6</option>
	        </select>
	      </div>
	      <label for="select" class="col-lg-2 control-label">Children (0-17)</label>
	      <div class="col-lg-4">
	        <select class="form-control" name="children">
	          <option>0</option>
	          <option>1</option>
	          <option>2</option>
	          <option>3</option>
	          <option>4</option>
	          <option>5</option>
	          <option>6</option>
	        </select>
	      </div>
	    </div>
	    <div class="form-group">
	      <div class="col-lg-10 col-lg-offset-2">
	        <button type="reset" class="btn btn-default">reset</button>
	        <span>&nbsp&nbsp</span>
	        <button type="submit" class="btn btn-primary">Submit</button>
	      </div>
	    </div>
	  </fieldset>
	</form>
  </div>
  
  <div class="tab-pane fade" id="multicity">
    <br>
	  <form class="form-horizontal" action='searchFlight.jsp'>
	  <fieldset>
	    <div class="form-group">
	      <label for="inputOrigin" class="col-lg-2 control-label">Flying from</label>
	      <div class="col-lg-4">
	        <input type="text" class="form-control" name="inputOrigin" placeholder="Origin">
	      </div>
	      <label for="inputDestination" class="col-lg-2 control-label">Flying to</label>
	      <div class="col-lg-4">
	        <input type="text" class="form-control" name="inputDestination" placeholder="Destination">
	      </div>
	    </div>
	    <div class="form-group">
	      <label for="inputDeparting" class="col-lg-2 control-label">Departing</label>
	      <div class="col-lg-4">
	        <input type="date" class="form-control" name="inputDeparting" >
	      </div>
	    </div>
	    <div class="form-group">
	      <label for="select" class="col-lg-2 control-label">Adults (18+)</label>
	      <div class="col-lg-4">
	        <select class="form-control" name="adults">
	          <option>1</option>
	          <option>2</option>
	          <option>3</option>
	          <option>4</option>
	          <option>5</option>
	          <option>6</option>
	        </select>
	      </div>
	      <label for="select" class="col-lg-2 control-label">Children (0-17)</label>
	      <div class="col-lg-4">
	        <select class="form-control" name="children">
	          <option>0</option>
	          <option>1</option>
	          <option>2</option>
	          <option>3</option>
	          <option>4</option>
	          <option>5</option>
	          <option>6</option>
	        </select>
	      </div>
	    </div>
	    <hr>
	    <div class="form-group">
	      <label for="inputOrigin2" class="col-lg-2 control-label">Flying from</label>
	      <div class="col-lg-4">
	        <input type="text" class="form-control" name="inputOrigin2" placeholder="Origin">
	      </div>
	      <label for="inputDestination2" class="col-lg-2 control-label">Flying to</label>
	      <div class="col-lg-4">
	        <input type="text" class="form-control" name="inputDestination2" placeholder="Destination">
	      </div>
	    </div>
	    <div class="form-group">
	      <label for="inputDeparting2" class="col-lg-2 control-label">Departing</label>
	      <div class="col-lg-4">
	        <input type="date" class="form-control" name="inputDeparting2" >
	      </div>
	      
	    </div>
	    <div class="form-group">
	      <div class="col-lg-10 col-lg-offset-2">
	        <button type="reset" class="btn btn-default">reset</button>
	        <span>&nbsp&nbsp</span>
	        <button type="submit" class="btn btn-primary">Submit</button>
	      </div>
	    </div>
	  </fieldset>
	</form>
  </div>
</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	// get current URL path and assign 'active' class
	var pathname = window.location.pathname;
	path = pathname.substr(pathname.lastIndexOf('/') + 1);
	$('.nav:first > li > a[href="'+path+'"]').parent().addClass('active');
})
</script>
</body>
</html>