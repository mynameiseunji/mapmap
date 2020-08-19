<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

p.station {
	
}

h1, h2, h3, h4, h5, h6 {
	font-family: 'Nanum Gothic', sans-serif;
	letter-spacing: 5px;
}

.col {
	padding: 10px;
}
</style>
<script defer src="<%=request.getContextPath()%>/js/all.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="<%=request.getContextPath()%>/js/friend.js"></script>
<script>
	Kakao.init('0b6c81e5d496e486ca93f4d82d0a0027');
	console.log(Kakao.isInitialized());
</script>

<script>

function sendLink(btn){
	
	
	var name = $(btn).data("name");
	var address = $(btn).data("address");
	var url = $(btn).data("url");
	var lastPage = "http://3.34.136.19/route.do?id="+'${id}';
	Kakao.Link.sendDefault({
		objectType: 'location',
		address: address,
		addressTitle: name,
		content: {
			title: '우리 지금 만나',
			imageUrl: 'https://minjoon93.s3.ap-northeast-2.amazonaws.com/img/city-map.png',
			link: {
				mobileWebUrl: lastPage,
				webUrl: lastPage,
			},
		},
		buttons: [
        {
        	title: '웹으로 보기',
        	link: {
        		mobileWebUrl: url,
        		webUrl: url,
        	},
		},
		],
	})
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
					<a href="member_login.do" class="w3-bar-item w3-button">로그인</a>
					<a href="member_join.do" class="w3-bar-item w3-button">회원가입</a>
				</c:if>
				<c:if test="${not empty email}">
					<div class="w3-dropdown-hover">
						<c:if test="${fn:length(fr_push) > 0}">
							<button id="fr_request" class="w3-button">친구요청&ensp;<span class="badge badge-light">${fn:length(fr_push)}</span></button>
							<div class="w3-dropdown-content w3-bar-block w3-card-4">
								<c:forEach var="fr_push" items="${fr_push}">
									<div class="w3-bar-item fr_push_list">
										<div class="w3-row">
											<div class="w3-col s6">
												<span class="w3-bar-item ontop">${fr_push.inviter}</span>
											</div>
											<div class="w3-col s3">
												<button class="w3-bar-item w3-button ontop" onclick="frpush('${fr_push.inviter}','1')">O</button>
											</div>
											<div class="w3-col s3">
												<button class="w3-bar-item w3-button ontop" onclick="frpush('${fr_push.inviter}','2')">X</button>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</c:if>
					</div>
					<a href="member_info.do" class="w3-bar-item w3-button">회원정보</a>
					<a href="member_logout.do" class="w3-bar-item w3-button">로그아웃</a>
				</c:if>
			</div>
			<div class="w3-right w3-hide-large w3-hide-medium">
				<!-- 로그인 세션 있으면 회원정보로-->
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
	<div class="container-sm table-responsive" style="margin-top: 80px">
		<div class="w3-row">
			<div class="w3-col s6" align="left">
				<h1>Route</h1>
			</div>
			<div class="w3-col s6" align="right">
				<c:if test="${original ==1}">
				<input type="button" class="btn btn-outline-warning" value="공유공유" data-name="${param.name}" data-address="${param.address}" data-url="${param.place_url}" onclick="sendLink(this)"/>
				</c:if>
			</div>
		</div>
		<table class="table">
			<tr align=center>
				<th>출발</th>
				<th colspan=2>경로</th>
				<th width="100px">시간</th>
			</tr>
			<c:forEach var="item" items="${departure}" varStatus="status">
				<tr>
					<td rowspan=2 style="vertical-align: middle; text-align: center">
					<i class="fas fa-user-alt fa-2x"></i>
						<p>출발지${status.count}</p>
						<p>${item}</p></td>
					<td width="70px">
						<p class="station">
							<i class="fas fa-bus"></i>
						</p>
					</td>
					<td>
						<p class="station">${bus_route[status.index]}</p>
					</td>
					<td align="center">
						<p>${bus_time[status.index]}분</p>
					</td>
				</tr>
				<tr>
					<td width="70px">
						<p class="station">
							<i class="fas fa-subway"></i><b>+</b><i class="fas fa-bus"></i>
						</p>
					</td>
					<td>
						<p class="station">${complex_route[status.index]}</p>
					</td>
					<td align="center">
						<p>${complex_time[status.index]}분</p>
					</td>
				</tr>
			</c:forEach>
			
		</table>
	</div>
	<br>
	<br>
	<footer class="w3-center w3-light-grey w3-padding-32">
		Contact Us 
		<div class="btn-group">
			<button onclick="location.href='https://github.com/mynameiseunji/mapmap'" title="github" class='btn'><i class="fab fa-github-square fa-lg"></i></button>		
		</div>
	</footer>
</body>
</html>


