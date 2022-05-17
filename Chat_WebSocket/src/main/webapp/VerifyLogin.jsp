<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*" %>    
<%@ page import="GetOutput.DBconnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String name=request.getParameter("name");  
	String password=request.getParameter("pass");
	Connection c=DBconnection.connects();
	PreparedStatement stmt=c.prepareStatement("select username from login where username=(?) and password=(?)");
	stmt.setString(1,name);
	stmt.setString(2,password);
	ResultSet RS=stmt.executeQuery();
	
	if(RS.next()) {  
		
		session.setAttribute("user",name);
		session.setAttribute("password",password);
		response.sendRedirect("Home.jsp");
	}
	else{
		PrintWriter des = response.getWriter();
		des.println("<html>");
		des.println("<body>");
		des.println("<script>");
		des.println("alert(\'Invalid Login Deatils Try Again ... \')");
		des.println("window.location.href=\'index1.jsp\'");
		des.println("</script>");
		des.println("</body>");
		des.println("</html>");
	}
%>
</body>
</html>