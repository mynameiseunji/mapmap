<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소 받기 테스트</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String str = request.getParameter("address");

%>

주소 : <%=str%>

데이타 : ${data}
</body>
</html>