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
<link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../../css/main.css">
<title>Revenue</title>
</head>
<body>
<%
  String username = (String) session.getAttribute("username");
  System.out.println("username " + username);
%>
<nav class="navbar navbar-inverse">
	  <div class="container-fluid">
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="../adminHomePage.jsp">Dashboard</a>
	    </div>
	
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
	      <ul class="nav navbar-nav">
	        <li><a href="../myCustomers.jsp">My Customers </a></li>
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Sales<span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="salesReport.jsp">Sales Report</a></li>
	            <li><a href="revenue.jsp">Revenue</a></li>
	          </ul>
	        </li>
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="true">Statistics <span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="../flightStatistics/reservations.jsp">Reservations</a></li>
	            <li><a href="../flightStatistics/flights.jsp">Flights</a></li>
	          </ul>
	        </li>
	      </ul>
	      
	      <ul class="nav navbar-nav navbar-right">
	        <li><a href="../../login.jsp">Sign out</a></li>
	      </ul>
	    </div>
	  </div>
	</nav>
<div class="container">
<h2>Revenue</h2>
<hr>
<div class="col-lg-3">
  <div class="list-group">
	  <a href="#" class="list-group-item active">By flight</a>
	  <a href="#" class="list-group-item">By destination city</a>
	  <a href="#" class="list-group-item">By customer</a>
  </div>
</div>

<div class="col-lg-9">
<table class="table table-striped table-hover ">
  <thead>
    <tr>
      <th>#</th>
      <th>Flight</th>
      <th>Revenue(US Dollar)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>AA</td>
      <td>13500</td>
    </tr>
    <tr>
      <td>2</td>
      <td>UA</td>
      <td>25600</td>
    </tr>
    <tr>
      <td>3</td>
      <td>SW</td>
      <td>3700</td>
    </tr>
  </tbody>
</table>
</div>
</div>
</body>
</html>