<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<title>My Account</title>
</head>
<body>
<%
String username = (String) session.getAttribute("username");
System.out.println("flight history, username=" + username);
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
<div class="container container container-padding">
<h3>My Account</h3>
<hr>
<div class="col-lg-3">
  <div class="list-group">
	  <a href="#" class="list-group-item active">My profile</a>
	  <a href="#" class="list-group-item">Settings</a>
  </div>
</div>
<div class="col-lg-9">
  <div class="well">
  <form class="form-horizontal">
  <fieldset>
    <legend>My profile</legend>
    <div class="form-group">
      <label for="inputOrigin" class="col-lg-2 control-label">Username</label>
      <div class="col-lg-4">
        <input type="text" class="form-control" id="inputUsername" >
      </div>
    </div>
    <hr>
    <div class="form-group">
      <label for="inputOrigin" class="col-lg-2 control-label">First name</label>
      <div class="col-lg-4">
        <input type="text" class="form-control" id="inputFirst" placeholder="First">
      </div>
      <label for="inputOrigin" class="col-lg-2 control-label">Last name</label>
      <div class="col-lg-4">
        <input type="text" class="form-control" id="inputLast" placeholder="Last">
      </div>
    </div>
    <div class="form-group">
      <label for="inputDeparting" class="col-lg-2 control-label">Social Security Number</label>
      <div class="col-lg-4">
        <input type="text" class="form-control" id="inputDeparting" >
      </div>
    </div>
    <hr>
    <div class="form-group">
      <label for="inputOrigin" class="col-lg-2 control-label">Address</label>
      <div class="col-lg-4">
        <input type="text" class="form-control" id="inputFirst" placeholder="Address">
      </div>
    </div>
    <div>
      <label for="inputOrigin" class="col-lg-2 control-label">City</label>
      <div class="col-lg-4">
        <input type="text" class="form-control" id="inputLast" placeholder="City">
      </div>
      <label for="inputOrigin" class="col-lg-2 control-label">State</label>
      <div class="col-lg-4">
        <input type="text" class="form-control" id="inputLast" placeholder="State">
      </div>
    </div>
    <hr>
    <div>
      <label for="inputOrigin" class="col-lg-2 control-label">Credit Card Number</label>
      <div class="col-lg-4">
        <input type="text" class="form-control" id="inputLast" placeholder="xxxx-xxxx-xxxx-xxxx">
      </div>
    </div>
    <br>
    <div class="form-group">
      <div class="col-lg-10 col-lg-offset-2">
        <button type="submit" class="btn btn-primary">Update</button>
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