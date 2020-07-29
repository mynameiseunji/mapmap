<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
		<a class="navbar-brand" href="#">Logo</a>
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
		</ul>
	</nav>
	<div id="map" class="container"
		style="margin-top: 80px; width: 100%; height: 350px;"></div>
	<div class="container" style="margin-top: 20px; margin-bottom: 20px">
<!-- 07.29 재성 (삭제 가능)--><span id="selected_location"></span> 
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active"
				data-toggle="tab" href="#home">location1</a></li>
			
		</ul>
		<form method="get" action="category.do" >
		<input type="hidden" id="selected_x" name="x" value="">
		<input type="hidden" id="selected_y" name="y" value="">
		<input type="hidden" id="selected_name" name="name" value="">
		<div class="tab-content">
			<div class="tab-pane container active" id="home">
			</div>
		<input type="submit" value="전송">
		</div>
		
		</form>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<%-- <div class="container">
		<!-- taglib prefix="fn"필요 -->
		입력된 출발지의 개수 : ${fn:length(addr)}
		<table class="table">
			<caption>출발지 목록</caption>
			<tr align='center'>
				<td>번호</td>
				<td>출발지</td>
				<td>X 좌표</td>
				<td>Y 좌표</td>
			</tr>
			<c:forEach var="addr" items="${addr}" varStatus="status">
				<tr>
					<td>${status.count}번</td>
					<td>${addr}</td>
					<td>X : ${x[status.index]}</td>
					<td>Y : ${y[status.index]}</td>
				</tr>
			</c:forEach>
		</table>
		<br> <br> 중심 좌표 <br> x : ${center.x} <br> y :${center.y} <br>
		
		<table class="table">
			<caption>지하철 역 -중심 좌표로 부터 거리 순</caption>
			<tr align='center'>
				<td>번호</td>
				<td>이름</td>
				<td>X 좌표</td>
				<td>Y 좌표</td>
			</tr>
			<c:forEach var="station" items="${stationList}" varStatus="status">
				<tr>
					<td>${status.count}번</td>
					<td>${station.name}</td>
					<td>X : ${station.x}</td>
					<td>Y : ${station.y}</td>
				</tr>
			</c:forEach>
		</table>
	</div> --%>
	<script>
		// 추천 후보지 보여주고 최종 좌표 값 다음 페이지로 넘기는 코드 ==== 시작 ===========================
		var possible_list_name = new Array();
		var posi_x = new Array();
		var posi_y = new Array();
		
		<c:forEach items="${stationList}" var="station" varStatus="status">
			possible_list_name.push('${station.name}');
			posi_x.push('${station.x}');
			posi_y.push('${station.y}');
		</c:forEach>
		
		var posi_li_active = '<h1>'+possible_list_name[0]+'</h1>'+
					'평균 소요 시간 :0000000<br>평균 거리 :00000000<br>'+
					'<span data-x="'+posi_x[0]+'" data-y="'+posi_y[0]+'"></span>'+
					'<input type="button" onclick="choice(this)" value="선택">';
		$('#home').append(posi_li_active);
		
		for(var i=1; i<possible_list_name.length; i++){
			
			var posi_li_fade = '<div class="tab-pane container fade" id="menu'+i+'">'+
							'<h1>'+possible_list_name[i]+'</h1>'+
							'평균 소요 시간 :0000000<br>평균 거리 :00000000<br>'+
							'<span data-x="'+posi_x[i]+'" data-y="'+posi_y[i]+'"></span>'+
							'<input type="button" onclick="choice(this)" value="선택"></div>';
							
			var posi_li_nav ='<li class="nav-item">'+
							'<a class="nav-link" data-toggle="tab" href="#menu'+i+'">'+
							possible_list_name[i]+'</a></li>';
			
			
			$('.tab-content').append(posi_li_fade);
			$('.nav.nav-tabs').append(posi_li_nav);
		}
		
		function choice(btn){
			//console.log($(btn).closest('div').children('span').data('x'));
			var coor_x = $(btn).closest('div').children('span').data('x');
			var coor_y = $(btn).closest('div').children('span').data('y');
			var pname= $(btn).closest('div').children('h1').text();
			$('#selected_location').text('선택된 장소 : '+pname);
			$('#selected_x').attr('value',coor_x);
			$('#selected_y').attr('value',coor_y);
			$('#selected_name').attr('value',pname);
		};
		// 추천 후보지 보여주고 최종 좌표 값 다음 페이지로 넘기는 코드 ==== 끝 ===========================
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		mapOption = {
			center : new kakao.maps.LatLng(37.56498949199894, 126.94852219358815), // 지도의 중심좌표 현재는 '이대역'로 설정
			level : 3
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 출발지 마커 좌표와 이름 
		var arr_x = new Array(); // 이대 홍대 당산
		var arr_y = new Array();
		var titles = new Array();
		
		var bounds = new kakao.maps.LatLngBounds();
		<c:forEach items="${sessionScope._x}" var="item" varStatus="sts">
			var xx = parseFloat('${item}');
			var yy = parseFloat('${sessionScope._y[sts.index]}');
			arr_x.push(xx);
			arr_y.push(yy);
			titles.push('${sessionScope._name[sts.index]}');
			bounds.extend(new kakao.maps.LatLng(yy, xx));
		</c:forEach>
		//모든 마커 보이게 지도 영역 설정
		map.setBounds(bounds);
		
		/*
		130~144 코드 와
		157~176 코드 합칠 수 있음.
		*/
		
		//마커 이미지의 이미지 주소입니다
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

		for (var i = 0; i < arr_x.length; i++) {

			// 마커 이미지의 이미지 크기 입니다
			var imageSize = new kakao.maps.Size(24, 35);

			// 마커 이미지를 생성합니다    
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
				map : map, // 마커를 표시할 지도
				
				position : new kakao.maps.LatLng(arr_y[i],arr_x[i]), // 마커를 표시할 위치
				
				title :	titles[i], // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
				
				image : markerImage
			// 마커 이미지 
			});
		}
		
	</script>
</body>

</html>

