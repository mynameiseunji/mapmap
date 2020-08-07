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
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b6c81e5d496e486ca93f4d82d0a0027&libraries=services"></script>
<script src="<%=request.getContextPath()%>/js/home.js"></script>
<script>
	/*
	로그인 세션 처리 (친구 목록을 세션으로 처리하고 있음)
	로그인 세션 있으면(컨트롤러에서 친구목록, 로그인 세션 넘어옴)
		1.버튼 value '로그인' => '회원 정보'로 변경
		2.친구 목록 리스트 보여주기. (main.jsp의 var fl 변수 참조)
	 */
	//친구목록 세션에 있을때
	//alert('${fr_email}');
	var fr_email = '${fr_email}'.split("#");	fr_email.pop();
	var fr_nick = '${fr_nick}'.split("#");	fr_nick.pop();
	var fr_x = '${fr_x}'.split("#");	fr_x.pop();
	var fr_y = '${fr_y}'.split("#");	fr_y.pop();

	$(document).ready(function() {
		//console.log('${sessionScope.email}'+"있습니다.");
		if ('${sessionScope.email}' != "") {
			$("#fl-list").append("친구 목록 있음/ 로그인 됨<br>");
			var tag = ""; //append될 태그 변수
			for (var i = 0; i < fr_email.length; i++) {
				//태그 쌓기
				tag += fr_email[i] + '<br>';
			}
			$("#fl-list").append(tag);
		} else {
			$("#fl-list").append("친구 목록 없음/ 로그인 안됨");

		}
	});

	window.onpageshow = function(event) {
		if (event.persisted
				|| (window.performance && window.performance.navigation.type == 2)) {
			// Back Forward Cache로 브라우저가 로딩될 경우 혹은 브라우저 뒤로가기 했을 경우
			console.log("뒤로가기로 들어왔습니다.");
			location.reload();
		} else {
			console.log("새로 진입123");
		}
	}
</script>
<body>

	<!-- Navbar (sit on top) -->
	<div class="w3-top w3-light-blue">
		<div class="w3-bar w3-white w3-padding w3-card"
			style="letter-spacing: 4px;">
			<a href="index.jsp" class="w3-bar-item w3-button">우리 지금 만나</a>
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
				<!-- 로그인 세션 있으면 회원정보로 --><!-- 로그인 세션 있으면 회원정보로-->
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
		<h3>출발지 목록</h3>

		<!-- Button to Open the Modal -->
		<div class="input-group mb-3">
			<input type="text" id="search_bar" class="form-control"
				placeholder="input your address">
			<div class="input-group-append">
				<button type="button" id="search" class="btn btn-dark"
					data-toggle="modal" data-target="#myModal">검색</button>
				<br>
			</div>

		</div>

	<div align="center">
	우리의 중간은 어디일까?<br>
	공평한 약속 장소를 찾을 수 있드록 도와드립니다.<br>
	참석자들의 출발지를 입력하시면 장소를 추천해드려요.<br>
	최대 10인.
	</div>
		<!-- The Modal -->
		<div class="modal" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">
							<b>&nbsp;&nbsp;Result</b>
						</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body" style='font-size: 18px'>
						<table id="table_part" class="w3-table w3-bordered w3-hoverable">
							<tbody wdith="100%">

							</tbody>
						</table>
					</div>


				</div>
			</div>
		</div>
	</div>
	<br>
	<hr>
	<br>
	<form id="form" action="sendAddr.do">
		<div class="container-sm">

			<ul class="w3-ul w3-card-4">
				<c:forEach items="${startPlaceList}" var="item">
					<li class="w3-bar">
					<span onclick="remove(this)" data-x='${item.x}'
						class="w3-bar-item w3-button w3-white w3-xlarge w3-right">×</span>
						<div class="w3-bar-item">
							<span class="w3-large">${item.name} </span><br>
							<span class="w3-addr"> ${item.address}</span>
						</div></li>

				</c:forEach>
			</ul>
			<div align="center">
				<button id="check_data" type="submit" class="btn btn-dark">전송</button>
			</div>
		</div>
		<c:forEach items="${startPlaceList}" var="item">
		<div class='place_values'>
			<input type='hidden' name='name' value='${item.name}'/>
			<input type='hidden' name='x' value='${item.x}'/>
			<input type='hidden' name='address' value='${item.address}'/>
			<input type='hidden' name='y' value='${item.y}'></div>
		</c:forEach>
	</form>
	<br>
	<br>
	<footer class="w3-center w3-light-grey w3-padding-32">
		<p>
			Powered by <a href="https://www.w3schools.com/w3css/default.asp"
				title="W3.CSS" target="_blank" class="w3-hover-text-green">w3.css</a>
		</p>
	</footer>
	<div id="fl-list"></div>
</body>
</html>