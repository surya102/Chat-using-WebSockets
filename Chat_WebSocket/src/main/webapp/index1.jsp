<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<script src="js/loginValid.js">
</script>
</head>
<body>
	<form action="VerifyLogin.jsp" method="post">
	 	Username: <input type="text" name="name" id="name"> <br>
	 	Password: <input type="password" name="pass" id="pass"> <br>
	 	<button onclick="check()">LOGIN</button><br>
	</form>
	<button onclick="close_tab()">CANCEL</button>
</body>
</html>