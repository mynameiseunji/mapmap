<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소 받기 테스트</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

%>


<c:forEach var="name" items="${coor}"  varStatus="status">
	<p>주소${status.count} : <c:out value="${address[status.index]}" /></p>
    <p>좌표 값 :: <c:out value="( ${name.x} , ${name.y} )" /></p><br>

</c:forEach>

</body>
</html>