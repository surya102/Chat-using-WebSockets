<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>    
<%@ page import="java.sql.*" %>
<%@ page import="GetOutput.DBconnection" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration Process Validate</title>
</head>
<body>
<%
	String name = request.getParameter("name");
	String username = request.getParameter("uname");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	String phoneno = request.getParameter("phone");
	
	try{
		Connection c = DBconnection.connects();
		String check="select * from login where username=(?)";
		PreparedStatement getIt = c.prepareStatement(check);
		getIt.setString(1,username);
		ResultSet rst = getIt.executeQuery();
		if(rst.next()){
			PrintWriter des = response.getWriter();
			des.println("<html>");
			des.println("<body>");
			des.println("<script>");
			des.println("alert(\"Username Already Exists..\"");
			des.println("window.location.href=\'Register.html\'");
			des.println("</script>");
			des.println("</body");
			des.println("</html>");
		}
		else{
			String sql = "insert into login values (?,?,?,?,?)";
			PreparedStatement stmt = c.prepareStatement(sql);
			stmt.setString(1,name);
			stmt.setString(2,username);
			stmt.setString(3,password);
			stmt.setString(4,email);
			stmt.setString(5,phoneno);
			stmt.executeUpdate();
			response.sendRedirect("index1.jsp");
		}	
	}
	catch(Exception e){
		System.out.println(e);
	}
%>
</body>
</html>