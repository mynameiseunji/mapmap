<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<title>title</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<style>
body {
	font-family: 'Nanum Gothic', sans-serif;
}
h1, h2, h3, h4, h5, h6 {
	font-family: 'Nanum Gothic', sans-serif;
	letter-spacing: 5px;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<body>

	<!-- Navbar (sit on top) -->
	<div class="w3-top w3-light-blue">
		<div class="w3-bar w3-white w3-padding w3-card"
			style="letter-spacing: 4px;">
			<a href="index.jsp" class="w3-bar-item w3-button">우리 지금 만나</a>
			<!-- Right-sided navbar links. Hide them on small screens -->
			<div class="w3-right w3-hide-small">
				<a href="member_login.do" class="w3-bar-item w3-button">로그인</a> <a
					href="member_join.do" class="w3-bar-item w3-button">회원가입</a>
			</div>
			<div class="w3-right w3-hide-large w3-hide-medium">
				<a class="w3-bar-item w3-button"> <i class="fa fa-user-circle"
					aria-hidden="true"> </i></a>
			</div>
		</div>
	</div>
	<div class='container-sm' style='max-width: 500px; margin-top: 80px'
		align="left">
		<h1>회원 정보</h1>
		<p>
			닉네임 : ${user.nickname}<br> 이메일 : ${user.email}<br> 출발지 : <br>
		</p>
		<ul class="w3-ul w3-large">
			<li>${user.addr1}</li>
			<li><c:if test="${empty user.addr2}">등록된 주소가 없습니다.^^</c:if>
				<c:if test="${not empty user.addr2}">${user.addr2}</c:if>
			</li>
			<li><c:if test="${empty user.addr2}">등록된 주소가 없습니다.^^</c:if>
				<c:if test="${not empty user.addr2}">${user.addr3}</c:if>
			</li>
		</ul>
		<br>
		<div class="w3-row">
			<div class="w3-col s3 w3-center">
				<button type="button" class="btn btn-outline-dark btn-lg" onclick="location.href='friend.jsp'">친구 정보</button>
			</div>
			<div class="w3-col s3 w3-center">
				<button type="button" class="btn btn-outline-dark btn-lg" onclick="location.href='member_edit.do'">정보 수정</button>
			</div>
			<div class="w3-col s3 w3-center">
				<button type="button" class="btn btn-outline-dark btn-lg" onclick="location.href='member_del.do'">회원 탈퇴</button>
			</div>
			<div class="w3-col s3 w3-center">
				<button type="button" class="btn btn-outline-dark btn-lg">로그 아웃</button>
			</div>
		</div>
	</div>
	<footer class="w3-center w3-light-grey w3-padding-32">
		<p>
			Powered by <a href="https://www.w3schools.com/w3css/default.asp"
				title="W3.CSS" target="_blank" class="w3-hover-text-green">w3.css</a>
		</p>
	</footer>
</body>
</html>