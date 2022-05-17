<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="GetOutput.DBconnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Creating Group</title>
</head>
<body>
<%
try{
	String GroupName= request.getParameter("cr_name");
	Connection c=DBconnection.connects();
	String sql="select groupname from groupname where groupname=(?)";
	PreparedStatement stmt=c.prepareStatement(sql);
	stmt.setString(1,GroupName);
	ResultSet rs=stmt.executeQuery();
	if(rs.next()){
		// already a group exists 
		PrintWriter des=response.getWriter();
		out.println("<html>");
		out.println("<body>");
		out.println("<script>");
		out.println("alert(\"Already Groups Exists\")");
		out.println("window.location.href=\'Home.jsp\'");
		out.println("</script>");
		out.println("</body>");
		out.println("</html>");
	}
	else{
		String ins="insert into groupname values(?)"; 
		stmt=c.prepareStatement(ins); 
		stmt.setString(1,GroupName); 
		stmt.executeUpdate();
		
		String name=(String)session.getAttribute("user");
		
		ins="insert into groups values(?,?,?)";
		stmt=c.prepareStatement(ins);
		stmt.setString(1,GroupName);
		stmt.setString(2,name);
		stmt.setString(3,"New user Joined !!!! ");
		stmt.executeUpdate();
		//System.out.println("Successfully created");
		
		session.setAttribute("user",name);
		session.setAttribute("group_Name",GroupName);
		response.sendRedirect("Group.jsp");
	}
}
catch(Exception e){
	
}
%>
</body>
</html>