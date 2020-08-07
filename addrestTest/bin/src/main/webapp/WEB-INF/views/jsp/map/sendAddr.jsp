<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소 받기 테스트</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b6c81e5d496e486ca93f4d82d0a0027&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	mapOption = {
		center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		level : 3
	// 지도의 확대 레벨
	};
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	//마커를 표시할 위치와 title 객체 배열입니다 
	var positions = [ {
		title : '카카오',
		latlng : new kakao.maps.LatLng(33.450705, 126.570677)
	}, {
		title : '생태연못',
		latlng : new kakao.maps.LatLng(33.450936, 126.569477)
	}, {
		title : '텃밭',
		latlng : new kakao.maps.LatLng(33.450879, 126.569940)
	}, {
		title : '근린공원',
		latlng : new kakao.maps.LatLng(33.451393, 126.570738)
	} ];
	//마커 이미지의 이미지 주소입니다
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	for (var i = 0; i < positions.length; i++) {
		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new kakao.maps.Size(24, 35);
		// 마커 이미지를 생성합니다    
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			map : map, // 마커를 표시할 지도
			position : positions[i].latlng, // 마커를 표시할 위치
			title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			image : markerImage
		// 마커 이미지 
		});
	}
</script>
<style>
.left {
	float: left;
	width: 50%;
}
.right {
	float: right;
	width: 50%;
}
</style>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
%>
<div id="map" class="container" style="margin-top:80px;width:100%;height:350px;">
<!-- 	<img class="w3-image w3-round-large" src="metro.png" alt="Buildings" -->
<!-- 		width="700" height="394"> -->
</div>

<div class="container" style="margin-top:20px">
	<div>
		<div>
			<div class="left">
				<h3>location1</h3>
				<p>
					Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
					eiusmod<br>tempor incididunt ut labore et dolore.
				</p>
				<p>
					<a href="detail.jsp" class="w3-button w3-black"><i
						class="fa fa-th"> </i> select</a>
				</p>
			</div>
			<div class="right">
				<h3>location2</h3>
				<p>
					Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
					eiusmod<br>tempor incididunt ut labore et dolore.
				</p>
				<p>
					<a href="detail.jsp" class="w3-button w3-black"><i
						class="fa fa-th"> </i> select</a>
				</p>
			</div>
		</div>


	</div>
</div>



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