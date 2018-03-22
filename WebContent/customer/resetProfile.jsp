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
		String newUsername = (String) session.getAttribute("username");
		String newSSN = request.getParameter("inputSSN");
		String newEmail = request.getParameter("inputEmail");
		String newFirstname = request.getParameter("inputFirst");
		String newLastname = request.getParameter("inputLast");
		String newAddress = request.getParameter("inputAddress");
		String newCity = request.getParameter("inputCity");
		String newState = request.getParameter("inputState");
		String newZipcode = request.getParameter("inputZip");
		String newPhone = request.getParameter("inputPhone");
		String newCredit = request.getParameter("inputCredit");
		System.out.println("reset profile: " + newUsername + " " + newSSN);
		
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
			Boolean hasCus = false;
			Boolean hasOwn = false;

			String str = "SELECT * FROM Customers c, Own o WHERE c.ssn=o.ssn AND o.username='" + newUsername + "'";
			String cusCheck = "SELECT * FROM Customers c WHERE c.ssn='" + newSSN + "'";
			ResultSet result = stmt.executeQuery(str);
			hasOwn = result.next();
			ResultSet cusResult = stmt.executeQuery(cusCheck);
			hasCus = cusResult.next();
			if (!hasOwn && !hasCus) {
				// Add a new customer
				// Check SSN
				if (newSSN == null || "".equals(newSSN)) {
					%>
					<script>
						alert("The SSN should not be null!");
						window.location.href = "myAccount.jsp";
					</script>
					<%
				} else {
					String query = "INSERT INTO Customers (ssn, lastname, firstname, address, city, state, zipcode, phone, credit_card_num)"
							+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
					String query2 = "INSERT INTO Own (ssn, username) VALUES(?, ?)";
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					pst = con.prepareStatement(query);
					System.out.println(query);

					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					pst.setString(1, newSSN);
					pst.setString(2, newLastname);
					pst.setString(3, newFirstname);
					pst.setString(4, newAddress);
					pst.setString(5, newCity);
					pst.setString(6, newState);
					pst.setString(7, newZipcode);
					pst.setString(8, newPhone);
					pst.setString(9, newCredit);
					//Run the query against the DB
					pst.executeUpdate();
					
					System.out.println(query2);
					pst = con.prepareStatement(query2);
					pst.setString(1, newSSN);
					pst.setString(2, newUsername);
					pst.executeUpdate();
					pst.close();
					%>
					<p class="lead text-success">
						&nbsp&nbsp&nbsp&nbspChange saved! <a href="myAccount.jsp">Go Back</a>
					</p>
					<script>
						window.location.href = "myAccount.jsp";
					</script>
					<%
				}
			} else {
				if (hasCus) {
					// If already has the customer, update Own
					String query = "INSERT INTO Own (ssn, username) VALUES(?, ?)";
					pst = con.prepareStatement(query);
					pst.setString(1, newSSN);
					pst.setString(2, newUsername);
					pst.executeUpdate();
				}
				// Update information
					String update = "UPDATE Customers c JOIN Own o using (ssn) SET c.lastname='" + newLastname + "', c.firstname='" + newFirstname
							 + "', c.address='" + newAddress + "', c.city='" + newCity + "', c.state='" + newState + "', c.zipcode='"
							 + newZipcode + "', c.phone='" + newPhone + "', c.credit_card_num='" + newCredit
							+ "' WHERE o.username='" + newUsername + "';";
					String updateEmail = "UPDATE Accounts SET email='" + newEmail + "' WHERE username='" + newUsername + "';";
					pst = con.prepareStatement(update);
					pst.executeUpdate(update);
					pst = con.prepareStatement(updateEmail);
					pst.executeUpdate(updateEmail);
					System.out.println(update);
					System.out.println(updateEmail);
					pst.close();
				%>
				<p class="lead text-success">
					&nbsp&nbsp&nbsp&nbspChange saved! <a href="myAccount.jsp">Go Back</a>
				</p>
				<script>
					window.location.href = "myAccount.jsp";
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