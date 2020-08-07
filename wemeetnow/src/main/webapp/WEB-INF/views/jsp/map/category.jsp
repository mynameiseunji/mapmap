<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<!DOCTYPE html>
<html>
<title>title</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
	font-family: 'Nanum Gothic', sans-serif;
}

h1, h2, h3, h4, h5, h6 {
	font-family: 'Nanum Gothic', sans-serif;
	letter-spacing: 5px;
}

.col {
	padding: 10px;
}
</style>
<script defer src="js/all.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- ------------------------------  -->
<script>

$(document).ready(function(){
	
	$("#cafelist").show();
	$("#foodlist").hide();
	$("#culturelist").hide();
	$("#travellist").hide();
	
	$("#cafe").click(function(){
		$("#cafelist").show();
		$("#foodlist").hide();
		$("#culturelist").hide();
		$("#travellist").hide();
	});

	$("#food").click(function(){
		$("#cafelist").hide();
		$("#foodlist").show();
		$("#culturelist").hide();
		$("#travellist").hide();
	});

	$("#culture").click(function(){
		$("#cafelist").hide();
		$("#foodlist").hide();
		$("#culturelist").show();
		$("#travellist").hide();
	});

	$("#travel").click(function(){
		$("#cafelist").hide();
		$("#foodlist").hide();
		$("#culturelist").hide();
		$("#travellist").show();
	});

});


</script>

<body>

	<!-- Navbar (sit on top) -->
	<div class="w3-top w3-light-blue">
		<div class="w3-bar w3-white w3-padding w3-card"
			style="letter-spacing: 4px;">
			<a href="test.do" class="w3-bar-item w3-button">Woori Jigum Manna</a>
			<!-- Right-sided navbar links. Hide them on small screens -->
			<div class="w3-right w3-hide-small">
				<!-- 로그인 세션 있으면 회원정보로-->
				<c:if test="${empty email}">
				<a href="member_login.do" class="w3-bar-item w3-button">로그인</a> <a
					href="member_join.do" class="w3-bar-item w3-button">회원가입</a>
				</c:if>
				<c:if test="${not empty email}">
				<a href="member_logout.do" class="w3-bar-item w3-button">로그아웃</a> <a
					href="member_info.do" class="w3-bar-item w3-button">회원정보</a>
				</c:if>
			</div>
			<div class="w3-right w3-hide-large w3-hide-medium">
				<!-- 로그인 세션 있으면 회원정보로 -->
				<c:if test="${empty email}">
				<a href="member_login.do" class="w3-bar-item w3-button"> <i
					class="fa fa-user-circle fa-lg" aria-hidden="true"> </i></a>
				</c:if>
				<c:if test="${not empty email}">
				<a href="member_info.do" class="w3-bar-item w3-button"> <i
					class="fa fa-user-circle fa-lg" aria-hidden="true"> </i></a>
				</c:if>
			</div>
		</div>
	</div>
	<div class="container-sm " align="center" style="margin-top: 80px">
		<!-- 
		<div class="container">
			<img src="map.png" style="width:100%">
		</div>
		 -->
		<br>
		<div class="row">
			<div class="col">
				<i id="cafe" class="fa fa-coffee fa-3x"></i>
				<h5>Cafe</h5>
			</div>
			<div class="col">
				<i id="food" class="fas fa-utensils fa-3x"></i>
				<h5>Food</h5>
			</div>
			<div class="col">
				<i id="culture" class="fa fa-film fa-3x"></i>
				<h5>Culture</h5>
			</div>
			<div class="col">
				<i id="travel" class="fas fa-archway fa-3x"></i>
				<h5>Travel</h5>
			</div>
		</div>
		<br>
		<div id="cafelist">
		<ul class="list-group">
			<c:forEach var="item" items="${ce7placeList}">
			<li class="list-group-item">
				${item.name} - ${item.address} - ${item.phone} -
				<a href="${item.place_url}">${item.place_url}</a>
			</li>
			</c:forEach>
		</ul>
		</div>
		<div id="foodlist">
		<ul class="list-group">
			<c:forEach var="item" items="${fd6placeList}">
			<li class="list-group-item">
				${item.name} - ${item.address} - ${item.phone} -
				<a href="${item.place_url}">${item.place_url}</a>
			</li>
			</c:forEach>
		</ul>
		</div>
		<div id="culturelist">
		<ul class="list-group">
			<c:forEach var="item" items="${ct1placeList}">
			<li class="list-group-item">
				${item.name} - ${item.address} - ${item.phone} - 
				<a href="${item.place_url}">${item.place_url}</a>
			</li>
			</c:forEach>
		</ul>
		</div>
		<div id="travellist">
		<ul class="list-group">
			<c:forEach var="item" items="${at4placeList}">
			<li class="list-group-item">
				${item.name} - ${item.address} - ${item.phone} - 
				<a href="${item.place_url}">${item.place_url}</a>
			</li>
			</c:forEach>
		</ul>
		</div>
	</div>
	<br>
	<br>
	
	<footer class="w3-center w3-light-grey w3-padding-32">
		<p>
			Powered by <a href="https://www.w3schools.com/w3css/default.asp"
				title="W3.CSS" target="_blank" class="w3-hover-text-green">w3.css</a>
		</p>
	</footer>
</body>
</html>

