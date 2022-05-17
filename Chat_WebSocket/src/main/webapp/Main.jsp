<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="GetOutput.DBconnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" http-equiv="Content-Type">
	<title>Home Page</title>
</head>
<body>

	<script src="js/Contents.js">
	</script>
	
	<button onclick="goback()">GO BACK</button>
	<br>
	
		<form action="logout.jsp">
		<button>LOGOUT</button>
	</form>
	<br>

 	<%
 		String sender=(String)session.getAttribute("sender");
 		String receiver=request.getParameter("Friend");
 		System.out.println();
	    if(sender==null || sender=="" || receiver.equals("Select Friend")){
	    	response.sendRedirect("Home.jsp");
	    }
 	%>
	<h1> Welcome to Chat Application ... </h1>
	<div id='Area'>
	 USER : <input type="text" id="Sender" name="Sender" value=<%=sender %> readonly><br><br>
	 FRIEND : <input type="text" id="Receiver" name="Receiver" value=<%=receiver %> readonly><br><br>
	 <script src="js/script.js">
	</script>
	<%
	    // Previous chat of user with particular user
	    try{
		     Connection c=DBconnection.connects();
			 String sql="select sender,message from messages where (sender=(?) and receiver=(?)) or (sender=(?) and receiver=(?))";
			 PreparedStatement stmt=c.prepareStatement(sql);
			 stmt.setString(1,sender);
			 stmt.setString(2,receiver);
			 stmt.setString(3,receiver);
			 stmt.setString(4,sender);
			 ResultSet rs=stmt.executeQuery();
			 while(rs.next()){
				 %><p><%=rs.getString(1)+" : "+rs.getString(2) %></p>
			 <% }
	    }
		catch(Exception e) { e.printStackTrace(); }
	%>
	</div>
	<br>
	<div id='msgArea'>
		<input type="text" id='message'>
		<button onclick="send()"> SEND </button>
	</div>
</body>
</html>