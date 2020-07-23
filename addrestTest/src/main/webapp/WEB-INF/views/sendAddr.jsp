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


<c:forEach var="ad" items="${addr}" >
	<p>주소 : <c:out value="${ad}" /></p>
</c:forEach>
<c:forEach var="xx" items="${x}" >
	<p>x : <c:out value="${xx}" /></p>
</c:forEach>
<c:forEach var="yy" items="${y}" >
	<p>y : <c:out value="${yy}" /></p>
</c:forEach>
</body>
</html>