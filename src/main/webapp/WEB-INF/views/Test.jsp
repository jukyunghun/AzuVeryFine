<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/login" method="post">
		<li><input name="email" type="text" placeholder="Email을 입력하세요"></li>
		<li><input name="pw" type="password" placeholder="PW를 입력하세요"></li>
		<li><input type="submit" value="LogIn" class="button fit"></li>
	</form>
</body>
</html>