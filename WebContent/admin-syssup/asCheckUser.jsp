<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<title>Checking User</title>
</head>
<body>
<%
	//Get parameters from the HTML form at the login.jsp
	String newName = request.getParameter("inputUsername");
	String newPswd = request.getParameter("inputPassword");
	out.print("<div class='progress progress-striped active'><div class='progress-bar' style='width: 100%'></div></div>");
	out.print("<p>&nbsp&nbsp&nbsp&nbsploading...</p>");
	
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
		try {
			//Create a connection to your DB
			con = DriverManager.getConnection(url, userName, password);
			//Create a SQL statement
			stmt = con.createStatement();
			//Get the combobox from the HelloWorld.jsp
			
			if ((newName.equals(""))||(newPswd.equals(""))){
				%>
				<script> 
				    alert("Please enter your account name and password");
				    window.location.href = "asLogin.jsp";
				</script>
				<% 
			} else {
				String str = "SELECT * FROM Accounts a WHERE a.username='" + newName + "' and a.password='" + newPswd + "'" + " and a.level=1";
	
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
	
				if (result.next()) {
					session.setAttribute("username", result.getString("username"));
					session.setAttribute("usertype", "admin");
					session.setAttribute("password", newPswd);
					System.out.println("Login success");
					%>
					<script> 
				    	window.location.href = "adminHomePage.jsp";
					</script>
					<%
					//close the connection.
				} else {
					System.out.print("Login error");
					%>
					<script> 
				    	alert("User and password mismatch, please enter a valid email and password");
				    	window.location.href = "asLogin.jsp";
					</script>
					<%
				}
			}
			con.close();

		} catch (Exception e) {
			out.print("failed");
		}
	%>

</body>
</html>