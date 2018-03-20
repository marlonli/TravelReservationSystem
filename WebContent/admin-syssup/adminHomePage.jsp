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
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<title>Manager Home Page</title>
</head>
<body>
<%
String username = (String) session.getAttribute("username");
String password = (String) session.getAttribute("password");
String ssn = "";
  if (username == null) {
%>
<script type="text/javascript">
  alert("Session expired, please login first");
  window.location.href = "asLogin.jsp";
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
		String getPswd = "SELECT password FROM Accounts WHERE username='" + username + "';";
		System.out.println(getPswd);
		ResultSet passwordResult = stmt.executeQuery(getPswd);
		if (passwordResult.next()) {
			password = passwordResult.getString("password");
			System.out.println(username + " " + password);
		}
		
		// Check if the user has ssn
		String checkSSN = "SELECT ssn FROM Managers m WHERE m.username='" + username + "'";
		System.out.println(checkSSN);

		ResultSet checkSSNResult = stmt.executeQuery(checkSSN);
		if (checkSSNResult.next()){
			ssn = checkSSNResult.getString("ssn") == null ? ssn : checkSSNResult.getString("ssn");
			%>
			<script type="text/javascript">
			$(document).ready(function() {
			  $("#inputSSN").attr('disabled', true);
			})
			</script>
			<% 
		}
		con.close();
	} catch (Exception ex) {
		System.out.println("error");
		System.out.println(ex);
		%> 
		<!-- if error, show the alert and go back to login page --> 
		<script> 
		    alert("Sorry, something went wrong on our server, failed to create your account");
		    window.location.href = "asLogin.jsp?signup";
		</script>
		<%
		return;
	}
%>

  <nav class="navbar navbar-inverse">
	  <div class="container-fluid">
	    <div class="navbar-header active">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="#">Dashboard <span class="sr-only">(current)</span></a>
	    </div>
	
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
	      <ul class="nav navbar-nav">
	        <li><a href="myCustomers.jsp">My Customers</a></li>
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Sales<span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="sales/salesReport.jsp">Sales Report</a></li>
	            <li><a href="sales/revenue.jsp">Revenue</a></li>
	          </ul>
	        </li>
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="true">Statistics <span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="flightStatistics/reservations.jsp">Reservations</a></li>
	            <li><a href="flightStatistics/flights.jsp">Flights</a></li>
	          </ul>
	        </li>
	      </ul>
	      
	      <ul class="nav navbar-nav navbar-right">
	        <li><a href="../login.jsp">Sign out</a></li>
	      </ul>
	    </div>
	  </div>
	</nav>
<div class="container">
<h3>Hello,  ${username}</h3>
<br>
<div class="row">
<div class="col-lg-8 col-lg-offset-2">
<div class="panel panel-primary">
  <div class="panel-heading">
    <h3 class="panel-title">Manage your Account</h3>
  </div>
  <div class="panel-body form-horizontal">
  <form class="register-form form-horizontal" method="post" action="resetPassword.jsp">
	<fieldset>
     <div class="form-group">
       <label for="inputSSN" class="col-lg-2 control-label">SSN</label>
         <div class="col-lg-10">
           <input type="text" class="form-control" id="inputSSN" name="inputSSN" value="<%=ssn%>" placeholder="Social Security Number">
         </div>
     </div>
     <hr>
     <div class="form-group">
       <label for="inputUsername" class="col-lg-2 control-label">Username</label>
         <div class="col-lg-10">
           <input type="text" class="form-control" id="inputUsername" name="inputUsername" value="<%=username%>" placeholder="Username" disabled="">
         </div>
     </div>
     <div class="form-group">
       <label for="inputPassword" class="col-lg-2 control-label">Password</label>
         <div class="col-lg-10">
           <input type="password" class="form-control" id="inputPassword" name="inputPassword" value="<%=password%>" placeholder="Password">
         </div>
     </div>
     <br>
     <div class="form-group">
	   <div class="col-lg-10 col-lg-offset-2">
	     <button type="submit" class="btn btn-primary" id="buttonUpdate">Update</button>
	   </div>
	 </div>
	 </fieldset>
	 </form>
  </div>
 </div>
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