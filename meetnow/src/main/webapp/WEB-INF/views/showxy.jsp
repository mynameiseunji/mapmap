<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
</head>
<body>

<form action="getstationcoord.do" method="post" name="coor">

	<input type="hidden" name="x" value="${coor.x}" id="x">
	<input type="hidden" name="y" value="${coor.y}" id="y">
		x : ${coor.x}
		y : ${coor.y}
	<input type="submit" name="submit">
</form>
</body>
</html>
