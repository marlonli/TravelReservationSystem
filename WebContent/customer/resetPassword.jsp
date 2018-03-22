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
<title>Reset Password</title>
</head>
<body>
<%
		//Get parameters from the HTML form at the settings.jsp
		String newUsername = (String) session.getAttribute("username");
		String newPswd1 = request.getParameter("inputPassword1");
		String newPswd2 = request.getParameter("inputPassword2");
		// Check password
		if (newPswd1 == null || "".equals(newPswd1) || newPswd1.length() < 6 || newPswd1.length() > 20 ||
				newPswd2 == null || "".equals(newPswd2) || newPswd2.length() < 6 || newPswd2.length() > 20) {
			%>
			<script>
				alert("The password should be at least 6 characters long and at most 20 characters long!");
				window.location.href = "settings.jsp";
			</script>
			<%
		} else if (newPswd1 != null && !newPswd1.equals(newPswd2)) {
			%>
			<script>
				alert("Passwords mismatch!");
				window.location.href = "settings.jsp"
			</script>
			<% 
		}
		out.print(
				"<div class='progress progress-striped active'><div class='progress-bar' style='width: 100%'></div></div>");
		// Create a connection string
		String hostname = "cs539-spring2018.cmvm3ydsfzmo.us-west-2.rds.amazonaws.com";
		String port = "3306";
		String dbName = "cs539proj1";
		String userName = "marlonli";
		String pswd = "123123123";
		String url = "jdbc:mysql://" + hostname + ":" + port + "/" + dbName;
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = null;
		PreparedStatement pst = null;

		try {
			con = DriverManager.getConnection(url, userName, pswd);
			//Create a SQL statement
			Statement stmt = con.createStatement();

			String str = "SELECT * FROM Accounts a WHERE a.username='" + newUsername + "'";
			ResultSet result = stmt.executeQuery(str);
			if (!result.next()) {
				%>
				<p class="message text-error">
					&nbsp&nbsp&nbsp&nbspSession expired <a
						href="../login.jsp">Login</a>
				</p>
				<script>
					alert("Your session is expired!");
					window.location.href = "../login.jsp";
				</script>
				<%
			} else {
				// Update password
				String updatePswd = "UPDATE Accounts SET password='" + newPswd1 + "' WHERE username='" + newUsername + "';";
				pst = con.prepareStatement(updatePswd);
				pst.executeUpdate(updatePswd);
				System.out.println(updatePswd);
				pst.close();
				%>
				<p class="lead text-success">
					&nbsp&nbsp&nbsp&nbspChange saved! <a href="settings.jsp">Go Back</a>
				</p>
				<script>
					window.location.href = "settings.jsp";
				</script>
				<% 
			}
		} catch (Exception ex) {
			System.out.println(ex);
	%>
			<!-- if error, show the alert and go back to last page -->
			<script>
				alert("Sorry, operation failed! Check again your input");
				window.location.href = "settings.jsp";
			</script>
			<%
		} finally {
			con.close();
		}
	%>
</body>
</html>