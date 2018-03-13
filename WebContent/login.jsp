<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Travel Reservation System</title>
</head>
<body>
<div class="login-page container">
<div class="row login-form-container">
	<div class="col-lg-6 col-lg-offset-3 panel panel-default">
	<div class="panel-body">
		<form class="login-form form-horizontal" method="post" action="checkUser.jsp">
		  <fieldset>
		    <legend>Login</legend>
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
		        <p class="message">Not registered? <a href="#">Create an account</a></p>
		        <p class="message">Admin or System support? <a href="admin-syssup/asLogin.jsp">Please log in here</a></p>
		      </div>
		    </div>
		  </fieldset>
		</form>
		
		<form class="register-form form-horizontal" method="post" action="newUser.jsp">
		  <fieldset>
		    <legend>Sign Up</legend>
		    <div class="form-group">
		      <label for="inputUsername" class="col-lg-2 control-label">Username</label>
		      <div class="col-lg-10">
		        <input type="text" class="form-control" name="inputUsername" placeholder="Username">
		      </div>
		    </div>
		    <div class="form-group">
		      <label for="inputEmail" class="col-lg-2 control-label">Email</label>
		      <div class="col-lg-10">
		        <input type="email" class="form-control" name="inputEmail" placeholder="Email">
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
		        <button class="btn btn-primary">Sign Up</button>
		        <p class="message">Already registered? <a href="#">Sign In</a></p>
		      </div>
		    </div>
		  </fieldset>
		</form>
	</div>
	</div>
</div>
</div>


</body>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript">
$(document).ready(function(){
	if (window.location.href.indexOf('signup')==-1){
		$('.login-form').show();
		$('.register-form').hide();
	} else {
		$('.login-form').hide();
		$('.register-form').show();
	}
});

$('.message a').click(function(){
	   $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
	});
</script>
</html>