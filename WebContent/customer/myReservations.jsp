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
<title>Reservation History</title>
</head>
<body>
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
</div>
<div class="col-lg-9">
<table class="table table-striped table-hover ">
  <thead>
    <tr>
      <th>#</th>
      <th>Flight Number</th>
      <th>Departure City</th>
      <th>Date</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>UA 111</td>
      <td>Newark</td>
      <td>March 20, 2018</td>
    </tr>
    <tr>
      <td>2</td>
      <td>AA 332</td>
      <td>New York</td>
      <td>March 19, 2018</td>
    </tr>
    <tr>
      <td>3</td>
      <td>UA 1030</td>
      <td>Boston</td>
      <td>March 18, 2018</td>
    </tr>
  </tbody>
</table>
</div>
</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
	// get current URL path and assign 'active' class
	var pathname = window.location.pathname;
	path = pathname.substr(pathname.lastIndexOf('/') + 1);
	$('.nav:first > li > a[href="'+path+'"]').parent().addClass('active');
})
</script>
</html>