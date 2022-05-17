<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<%@ page import="GetOutput.DBconnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
<script>
	function on(){
		var user=document.getElementById('name').value,user2=document.getElementById('Friend').value;
		if(user!=null && user2 != "Select Friend") {
			alert("User : "+user);
		}
		else alert("Invalid Details");
	}
</script>
</head>
<body>
	<form action="logout.jsp">
		<button>LOGOUT</button>
	</form>
	<br>
<%
	String name=(String)session.getAttribute("user");
%>
<form action="Main.jsp">
	User : <input type="text" id='name' value=<%=name %> >
	<select name="Friend" id="Friend">
<option>Select Friend </option>
<%
String Receiver;
try{
	Connection c=DBconnection.connects();
	PreparedStatement stmt=c.prepareStatement("select * from login");
	ResultSet rs=stmt.executeQuery();
	while(rs.next()){
		%><option><%=rs.getString(1) %></option><%
	}
}catch(Exception e){e.printStackTrace();}	
%>
</select>
<button onclick=on()>Click Me</button>
</form>

<%
	session.setAttribute("sender",name);
%>

<br>
<h1> Group Chat </h1>
<form action="GroupCreate.jsp" method="post">
		CREATE GROUP : <input type="text" name="cr_name" id="crgorup" > 
		<button>CREATE GROUP</button>
</form>		
<form action="JoinGroup.jsp" method="post">	
		<br>
		ENTER GROUP NAME TO JOIN:  <input type="text" name="gr_name" id="jgroup"> 
		<button>JOIN GROUP</button>
		<br>
</form>
</body>
</html>