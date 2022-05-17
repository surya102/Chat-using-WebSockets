<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "GetOutput.DBconnection" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Deleting Group</title>
</head>
<body>
<%	
	String grpname = (String) session.getAttribute("group_Name");
	Connection c = DBconnection.connects();
	String Sql = "delete from groupname where groupname = (?)";
	PreparedStatement stmt = c.prepareStatement(Sql);		
	stmt.setString(1,grpname);
	stmt.executeUpdate();
	out.println("<html>");
	out.println("<body style = text-align:center; display:center;>");
	out.println("<script>");
	out.println("document.writeln(\'Group Deleted Successully ... Redirecting To Home Page\')");
	out.println("setTimeout(function(){window.location.href=\'Home.jsp\';}, 3000)"); 
	out.println("</script></body></html>");
%>
</body>
</html>