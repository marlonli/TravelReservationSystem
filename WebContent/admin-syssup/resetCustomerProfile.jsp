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
<title>Update Profile</title>
</head>
<body>
<%
	// Get parameters from the HTML form at the myAccount.jsp
		String newSSN = request.getParameter("inputSSN");
		String newFirstname = request.getParameter("inputFirst");
		String newLastname = request.getParameter("inputLast");
		String newAddress = request.getParameter("inputAddress");
		String newCity = request.getParameter("inputCity");
		String newState = request.getParameter("inputState");
		String newZipcode = request.getParameter("inputZip");
		String newPhone = request.getParameter("inputPhone");
		String newCredit = request.getParameter("inputCredit");
		System.out.println("reset customer profile, ssn=" + newSSN);
		
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

			String str = "SELECT * FROM Customers c WHERE c.ssn='" + newSSN + "'";
			ResultSet result = stmt.executeQuery(str);
			if (!result.next()) {
				// No record in database
					%>
					<script>
						alert("Cannot find the customer!");
						window.location.href = "myCustomers.jsp";
					</script>
					<%
			} else {
				// Update the information
					String update = "UPDATE Customers c SET c.lastname='" + newLastname + "', c.firstname='" + newFirstname
							 + "', c.address='" + newAddress + "', c.city='" + newCity + "', c.state='" + newState + "', c.zipcode='"
							 + newZipcode + "', c.phone='" + newPhone + "', c.credit_card_num='" + newCredit
							+ "' WHERE c.ssn='" + newSSN + "';";
					pst = con.prepareStatement(update);
					pst.executeUpdate(update);
					System.out.println(update);
					pst.close();
					session.setAttribute("ssn", newSSN);
				%>
				<p class="lead text-success">
					&nbsp&nbsp&nbsp&nbspChange saved!
				</p>
				<script>
					window.location.href = "myCustomers.jsp";
				</script>
				<%
			}
		} catch (Exception ex) {
			System.out.println(ex);
	%>
	<!-- if error, show the alert and go back to admin page -->
	<script>
		alert("Sorry, operation failed! Please check your input");
		window.location.href = "myAccount.jsp";
	</script>
	<%
		} finally {
			con.close();
		}
	%>
</body>
</html>