<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Logging in...</title>
</head>
<body>
	<div class="progress progress-striped active">
  	  <div class="progress-bar" style="width: 45%"></div>
    </div>
	<%

		try {
			//Create a connection string
			String hostname = "cs539-spring2018.cmvm3ydsfzmo.us-west-2.rds.amazonaws.com";
			String port = "3306";
			String dbName = "cs539proj1";
			String userName = "marlonli";
			String password = "123123123";
			String url = "jdbc:mysql://" + hostname + ":" + port + "/" + dbName;
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, userName, password);
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the HelloWorld.jsp
			
			//Get parameters from the HTML form at the login.jsp
			
		    String newUsername = request.getParameter("inputUsername");
		    String newPswd = request.getParameter("inputPassword");
		    
			if ((newUsername.equals(""))&&(newPswd.equals(""))){
				%>
				<script> 
				    alert("Please enter your email and password");
				    window.location.href = "login.jsp";
				</script>
				<% 
			} else {
				String str = "SELECT * FROM Accounts a WHERE a.username='" + newUsername + "' and a.password='" + newPswd + "'";
	
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				//System.out.println(str);
	
				if (result.next()) {
					if (result.getInt("level") == 1) {
						// manager account
						session.setAttribute("username", result.getString("username"));
						session.setAttribute("usertype", "admin");
					%>
						<script> 
				    			window.location.href = "admin-syssup/adminHomePage.jsp";
						</script>
					<%
					} else if (result.getInt("level") == 0){
						session.setAttribute("username", result.getString("username"));
						session.setAttribute("usertype", "customer");
					%>
						<script> 
					 	    //alert("login success!");
				    			window.location.href = "customer/customerHomePage.jsp";
						</script>
					<%
					}
				} else {
					System.out.print("User not found");
					%>
					<script> 
				    	alert("User not found, or you entered a wrong password.");
				    	window.location.href = "login.jsp";
					</script>
					<%
				}
			}
			con.close();

		} catch (Exception e) {
			out.print("failed");
			%>
			<script> 
		    	alert("Sorry, unexcepted error happens.");
		    	window.location.href = "login.jsp";
			</script>
			<%			
		}
	%>

</body>
</html>