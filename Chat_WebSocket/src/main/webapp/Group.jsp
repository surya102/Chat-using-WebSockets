<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="GetOutput.DBconnection" %> 
<%@ page import="java.sql.*" %>   	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Group Chat</title>
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
		String Group_Name = (String)session.getAttribute("group_Name");
		String user = (String)session.getAttribute("user");
		
		session.setAttribute("group_Name",Group_Name);
		session.setAttribute("user",user);
	%>
	Group Name : <input type="text" name="group" id="group" value=<%=Group_Name %> readonly> <br>
	Group User : <input type="text" name="user" id="user" value=<%=user %> readonly><br>
	<p> Group Users </p>
	<script src="js/groupscript.js">
	</script>
	
	<div id='Ref'> <ul>
	<% 
	try{
		Connection c = DBconnection.connects();
		String sql = "select distinct username from groups where groupname = (?)";
		PreparedStatement stmt = c.prepareStatement(sql);
		stmt.setString(1,Group_Name);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) { 
			%>  
			   <li> <%=rs.getString(1)%> </li>
			   <% 
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
%>

	</ul>
	</div>
	<%
		try{
			Connection c=DBconnection.connects();
			String sql = "select username,messages from groups where groupname=(?)";
			PreparedStatement stmt = c.prepareStatement(sql);
			stmt.setString(1,Group_Name);
			ResultSet output = stmt.executeQuery();
			for(;output.next();){
				%> <p> <%= output.getString(1)+" : "+output.getString(2)%> </p>
			<% }
		}
		catch(Exception e){
			e.printStackTrace();
		}
	%>
	<br>
		<div id='Area' >
		</div>
		Message <input type = "text"  id="msg" class="msg">
		<button onclick = "send()" > SEND </button>
	<form action="DeleteGroup.jsp" method="post">
		<button> Delete Group </button> 
	</form>	
	
</body>
</html>