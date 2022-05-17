<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="GetOutput.DBconnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Joining Group</title>
</head>
<body>
	<%
	try{
		String GroupName = request.getParameter("gr_name");
		Connection c=DBconnection.connects();
		String sql="select groupname from groupname where groupname=(?)";
		PreparedStatement stmt=c.prepareStatement(sql);
		stmt.setString(1,GroupName);
		ResultSet rs=stmt.executeQuery();
		if(rs.next()){
			String name=(String)session.getAttribute("user");
			session.setAttribute("user",name);
			
			sql="select distinct username from groups where username = (?)";
			stmt=c.prepareStatement(sql);
			stmt.setString(1,name);
			rs=stmt.executeQuery();
			
			if(!rs.next()){
				sql="insert into groups values(?,?,?)";
				stmt=c.prepareStatement(sql);
				stmt.setString(1,GroupName);
				stmt.setString(2,name);
				stmt.setString(3,"New user Joined !!!! ");
				stmt.executeUpdate();
			}
			// Group already exits join group
			session.setAttribute("group_Name",GroupName);
			response.sendRedirect("Group.jsp");
		}
		else{
			PrintWriter des=response.getWriter();
			des.println("<html>");
			des.println("<body>");
			des.println("<script>");
			des.println("alert(\"Group Does not Exists.. Invalid Group Name\")");
			des.println("window.location.href=\'Home.jsp\'");
			des.println("</script>");
			des.println("</body>");
			des.println("</html>");
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	%>
</body>
</html>