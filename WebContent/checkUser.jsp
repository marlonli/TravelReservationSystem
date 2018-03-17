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
		    String newEmail = request.getParameter("email");
		    String newPswd = request.getParameter("password");
		    
		    //if it is an admin
		    if((newEmail.equals("admin"))&&(newPswd.equals("admin"))){
		    	session.setAttribute("username", "admin");
		    	%><script>
		    	window.location.href = "admin-syssup/admin.jsp";
		    	</script>
		    	<%
		    	return;
		    }
		    
			if ((newEmail.equals(""))&&(newPswd.equals(""))){
				%>
				<script> 
				    alert("Please enter your email and password");
				    window.location.href = "login.jsp";
				</script>
				<% 
			} else {
				String str = "SELECT * FROM Accounts e WHERE e.email='" + newEmail + "' and e.password='" + newPswd + "'";
	
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				//System.out.println(str);
	
				if (result.next()) {
					//out.print("login success! Welcome: ");
					//out.print(result.getString("user_name"));
					//Integer locked = result.getObject("locked") != null ? result.getInt("locked") : null;
					//System.out.println(locked);

					if( result.getObject("locked") == null ){
						session.setAttribute("username", result.getString("username"));
						session.setAttribute("email", newEmail);
						%>
						<script> 
					 	    //alert("login success!");
				    		window.location.href = "driverOrPassenger.jsp";
						</script>
					<%
					}
					else if(result.getInt("locked")==0){
						session.setAttribute("user_name", result.getString("user_name"));
						session.setAttribute("email", newEmail);
						session.setAttribute("user_type", "end_user");

						%>
						<script> 
					 	   //alert("login success!");
				    		window.location.href = "driverOrPassenger.jsp";
						</script>
					<%						
					}
					else if (result.getInt("locked")==1){
						%>
						<script> 
					    	alert("Sorry, the user is locked and cannot log in now");
					    	window.location.href = "login.jsp";
						</script>
						<%						
					}
					//close the connection.
				} else {
					out.print("User not found");
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