<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<title>Travel Reservation System</title>
</head>
<body>
<div class="login-page container">
	<div class="row login-form-container">
		<div class="col-lg-6 col-lg-offset-3 panel panel-default">
			<div class="panel-body">
				<form class="login-form form-horizontal" method="post" action="asCheckUser.jsp">
				  <fieldset>
				    <legend>Manager Login</legend>
				    <div class="form-group">
				      <label for="inputUsername" class="col-lg-2 control-label">Username</label>
				      <div class="col-lg-10">
				        <input type="text" class="form-control" name="inputUsername" placeholder="Username">
				      </div>
				    </div>
				    <div class="form-group">
				      <label for="inputPassword" class="col-lg-2 control-label">Password</label>
				      <div class="col-lg-10">
				        <input type="password" class="form-control" name="inputPassword" placeholder="Password">
				      </div>
				    </div>
				    <div class="form-group">
				      <div class="col-lg-10 col-lg-offset-2">
				        <button type="submit" class="btn btn-primary">Sign In</button>
				        <p class="message">Not a manager? <a href="../login.jsp">Please login here</a></p>
				      </div>
				    </div>
				  </fieldset>
				</form>
     		</div>
     	</div>
     </div>
</div>
</body>
</html>