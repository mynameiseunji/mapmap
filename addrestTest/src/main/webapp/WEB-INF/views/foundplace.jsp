<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
<title>Test found station list</title>
</head>
<body>
입력된 출발지의 개수 :  ${fn:length(addr)}
	<table border=1>
		<caption>출발지 목록</caption>
		<tr align='center'>
			<td>번호</td>
			<td>출발지</td>
			<td>X 좌표</td>
			<td>Y 좌표</td>
		</tr>
		<c:forEach var="addr" items="${addr}" varStatus="status">
			<tr>
				<td> ${status.count}번 </td>
				<td> ${addr} </td>
				<td> X : ${x[status.index]} </td>
				<td> Y : ${y[status.index]} </td>
			</tr>
		</c:forEach>
	</table>
	<br><br>
	중심 좌표
	<br> x : ${center.x}
	<br> y : ${center.y}
	<br>
	<table border=1>
		<caption>지하철 역 -중심 좌표로 부터 거리 순</caption>
		<tr align='center'>
			<td>번호</td>
			<td>이름</td>
			<td>X 좌표</td>
			<td>Y 좌표</td>
		</tr>
		<c:forEach var="station" items="${stationList}" varStatus="status">
			<tr>
				<td> ${status.count}번 </td>
				<td> ${station.subName} </td>
				<td> X : ${station.xs} </td>
				<td> Y : ${station.ys} </td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
