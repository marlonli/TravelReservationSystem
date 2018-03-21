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
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<title>Search For Flights</title>
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
<nav class="navbar navbar-inverse">
	  <div class="container-fluid">
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
	        <li><a href="reservations.jsp">Reservations</a></li>
	        <li><a href="searchFlight.jsp">Search Flight</a></li>
	        <li><a href="myAccount.jsp">My Account</a></li>
	      </ul>
	      
	      <ul class="nav navbar-nav navbar-right">
	        <li><a href="../login.jsp">Sign out</a></li>
	      </ul>
	    </div>
	  </div>
</nav>
<div class="container">
<h3>Search For a Flight</h3>
<hr>
<div class="col-lg-12">
  <div class="well">
  <form class="form-horizontal">
  <fieldset>
    <div class="form-group">
      <label class="col-lg-2 control-label">Trip</label>
      <div class="col-lg-10">
        <div class="radio col-lg-4">
          <label>
            <input type="radio" name="oneWay" id="radioOneWay" value="oneWay" checked="">
            One way
          </label>
        </div>
        <div class="radio col-lg-4">
          <label>
            <input type="radio" name="roundTrip" id="radioRoundTrip" value="roundTrip">
            Round trip
          </label>
        </div>
        <div class="radio col-lg-4">
          <label>
            <input type="radio" name="multiCity" id="radioMultiCity" value="multiCity">
            Multi-city
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <label for="inputOrigin" class="col-lg-2 control-label">Flying from</label>
      <div class="col-lg-4">
        <input type="text" class="form-control" id="inputOrigin" placeholder="Origin">
      </div>
      <label for="inputDestination" class="col-lg-2 control-label">Flying to</label>
      <div class="col-lg-4">
        <input type="password" class="form-control" id="inputDestination" placeholder="Destination">
      </div>
    </div>
    <div class="form-group">
      <label for="inputDeparting" class="col-lg-2 control-label">Departing</label>
      <div class="col-lg-4">
        <input type="date" class="form-control" id="inputDeparting" >
      </div>
      <label for="inputReturning" class="col-lg-2 control-label">Returning</label>
      <div class="col-lg-4">
        <input type="date" class="form-control" id="inputReturning" >
      </div>
    </div>
    <div class="form-group">
      <label for="select" class="col-lg-2 control-label">Adults (18+)</label>
      <div class="col-lg-4">
        <select class="form-control" id="adults">
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
        <select class="form-control" id="children">
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