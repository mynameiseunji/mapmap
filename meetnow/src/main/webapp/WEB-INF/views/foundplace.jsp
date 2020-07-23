<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>Test found station list</title>
</head>
<body>
test
	<table>
		<c:forEach var="station" items="${stationList}">
			<tr>
				<td>지하철역 이름 : </td>
				<td>${station.subName}</td>
				<td>지하철역 X : </td>
				<td>${station.xs}</td>
				<td>지하철역 Y : </td>
				<td>${station.ys}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
