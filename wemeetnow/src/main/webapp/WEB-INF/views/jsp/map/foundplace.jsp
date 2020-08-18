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
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- T맵 api -->
<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx45b1d9cc7eb14ee98cb9d6aca431df5e"></script>

</head>
<body>
<!-- Navbar (sit on top) -->
	<div class="w3-top w3-light-blue">
		<div class="w3-bar w3-white w3-padding w3-card"
			style="letter-spacing: 4px;">
			<a href="index.jsp" class="w3-bar-item w3-button">Woori Jigum
				Manna</a>
			<!-- Right-sided navbar links. Hide them on small screens -->
			<div class="w3-right w3-hide-small">
				<a href="loginform.jsp" class="w3-bar-item w3-button">Sign In</a> <a
					href="joinform.jsp" class="w3-bar-item w3-button">Sign Up</a>
			</div>
			<div class="w3-right w3-hide-large w3-hide-medium">
				<a href="login.jsp" class="w3-bar-item w3-button"> <i
					class="fa fa-user-circle fa-lg" aria-hidden="true"> </i></a>
			</div>
		</div>
	</div>
	<div class="container-sm " align="center" style="margin-top: 80px">
		<div id="map_div" class="container"
			style="margin-top: 80px; width: 100%; height: 350px;"></div>

		<div class='container-sm'>


			<div class="container" style="margin-top: 20px; margin-bottom: 20px">
				<span id="selected_location"></span>
				<ul class="nav nav-tabs">
					<li class="nav-item">
						<!--          <a class="nav-link active" --> <!--             data-toggle="tab" href="#home" onclick="drawmap(1)">location1</a> -->
					</li>

				</ul>
			</div>
			<form method="get" action="category.do">
				<input type="hidden" id="selected_x" name="x" value=""> <input
					type="hidden" id="selected_y" name="y" value=""> <input
					type="hidden" id="selected_name" name="name" value="">
				<div class="tab-content">
					<div class="tab-pane container active" id="home"></div>

				</div>

				<input class="btn btn-dark" type='submit' value='결정'>
			</form>
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
	
	<script>
   
      //각 장소에대한 친구들의 경로 정보  => 장소1까지 친구1읠 경로/장소1까지 친구2의 경로/...
      var path_list = '${pathInfo}'.split('/');      
      path_list.pop();
      //출발지 갯수
      var x_num = parseInt('${x_num}');
      
      //파싱된 경로가 저장될 배열
      var times = new Array();
      //각 도착지에 대한 친구들의 정보 종합.
      for(var i=0; i<path_list.length/x_num; i++){
         var str = "";
         for(var j=0; j<x_num; j++){
        	 console.log(path_list[i*x_num+j])
            if(path_list[i*x_num+j]=="NONE"){
               //str +='<p>출발지 '+(j+1)+'번 예상 이동시간(도보) : 분</p>';
               str += '<p>출발지 '+(j+1)+'번 : 이용할 수 있는 대중 교통이 없습니다.';
            }else{
            	var path_arr = path_list[i*x_num+j].split('#');
            	var time = path_arr[path_arr.length-2];
            	
               str += '<p>출발지'+(j+1)+'번 예상 이동시간(대중교통)  : '+time+'분</p>';   
            }
            
         }
         times.push(str);
      }   
      
      // 추천 후보지 보여주고 최종 좌표 값 다음 페이지로 넘기는 코드 ==== 시작 ===========================
      // 컨트롤러에서 후보지 정보 받아와서 배열생성
      // name#x#y#name#x#y...형식
            
      // tmap에 사용할 도착지점 x,y 배열 생성
      var endPlaceList_x = '${endPlaceList_x}'.split("#");
      var endPlaceList_y = '${endPlaceList_y}'.split("#")
      var endPlaceList_name = '${endPlaceList_name}'.split("#")
      endPlaceList_x.pop();
      endPlaceList_y.pop();
      endPlaceList_name.pop();
      var epl_num = endPlaceList_x.length;

      //append.
      var cen = 'center';
      $('#selected_x').attr('value',endPlaceList_x[0]);
      $('#selected_y').attr('value',endPlaceList_y[0]);
      $('#selected_name').attr('value',endPlaceList_name[0]);
      
      // .tab-content 자손태그로 추가(반복)
      for(var i=1; i<epl_num; i++){
         
         var posi_li_fade = '<div class="tab-pane container fade" id="menu'+i+'">'+
                     '<h1>'+endPlaceList_name[i]+'</h1>'+
                     times[i-1]+'</p><span data-x="'
                     +endPlaceList_x[i]+'" data-y="'+endPlaceList_y[i]+'"></span></div>';
                     
         var posi_li_nav ='<li class="nav-item">'+      
					         '<span data-name="'+endPlaceList_name[i]+
					         '" data-x="'+endPlaceList_x[i]+
					         '" data-y="'+endPlaceList_y[i]+
					         '"></span>' +
					         '<a id= "loc' + i + '" class="nav-link" '+
					         'data-toggle="tab" href="#menu' + i + '" onclick="remarker(' + i + ')" >' +
					         endPlaceList_name[i]+'</a></li>';
         
         
         $('.tab-content').append(posi_li_fade);
         $('.nav.nav-tabs').append(posi_li_nav);
      }
        
		// 출발지 마커 좌표와 이름 
		var startPlaceList_x = '${startPlaceList_x}'.split("#");
		var startPlaceList_y = '${startPlaceList_y}'.split("#")
		var startPlaceList_name = '${startPlaceList_name}'.split("#")
		startPlaceList_x.pop();
		startPlaceList_y.pop();
		startPlaceList_name.pop();
		var spl_num = startPlaceList_x.length;

		// 1. 지도 띄우기
		var map = new Tmapv2.Map("map_div", {
			center : new Tmapv2.LatLng(endPlaceList_y[0], endPlaceList_x[0]),
			width : "80%",
			height : "50%"
		});
		var marker_s;
		var marker_e = [];
		var totalMarkerArr = [];
		var drawInfoArr = [];
		var resultdrawArr = [];
		// 2. 시작, 도착 심볼찍기
		// 시작
		for (var i = 0; i < startPlaceList_x.length; i++) {
			marker_s = new Tmapv2.Marker(
					{
						position : new Tmapv2.LatLng(startPlaceList_y[i],
								startPlaceList_x[i]),
						icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_b_s.png",
						title : startPlaceList_name[i],
						iconSize : new Tmapv2.Size(32, 50),
						map : map
					});
		}
		// 중심 마크 그리기 marker_e[0]
		marker_e[0] = new Tmapv2.Marker(
				{
					position : new Tmapv2.LatLng(endPlaceList_y[0],
							endPlaceList_x[0]),
					icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_w_m_c.png",
					title : endPlaceList_name[0],
					iconSize : new Tmapv2.Size(32, 50),
					map : map
				});
		// 추천 지역들 찍기 marker_e[1]~[5]
		for (var i = 1; i < epl_num; i++) {
			marker_e[i] = new Tmapv2.Marker(
					{
						position : new Tmapv2.LatLng(endPlaceList_y[i],
								endPlaceList_x[i]),
						icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_g_m_r.png",
						title : endPlaceList_name[i],
						map : map,
					});
		}
		eplmarkerevent(0); // 추천 마크 이벤트들 실행
		
		//  경로탐색 API 사용요청
		for (var t = 0; t < spl_num; t++) {
			for (var j = 0; j < 100000000; j++) {
			}
			$
					.ajax({
						method : "POST",
						url : "https://apis.openapi.sk.com/tmap/routes/pedestrian?version=1&format=json&callback=result",//
						async : false,
						data : {
							appKey : "l7xx45b1d9cc7eb14ee98cb9d6aca431df5e",
							startX : startPlaceList_x[t],
							startY : startPlaceList_y[t],
							endX : endPlaceList_x[0],
							endY : endPlaceList_y[0],
							reqCoordType : "WGS84GEO",
							resCoordType : "EPSG3857",
							startName : "출발지",
							endName : "도착지"
						},
						success : function(response) {
							var resultData = response.features;
							drawInfoArr = []; // 경로 좌표들 저장하는 배열
							for ( var i in resultData) { //for문 [S]
								var geometry = resultData[i].geometry;
								var properties = resultData[i].properties;
								var polyline_;
								if (geometry.type == "LineString") {
									for ( var j in geometry.coordinates) {
										// 경로들의 결과값(구간)들을 포인트 객체로 변환 
										var latlng = new Tmapv2.Point(
												geometry.coordinates[j][0],
												geometry.coordinates[j][1]);
										// 포인트 객체를 받아 좌표값으로 변환
										var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
												latlng);
										// 포인트객체의 정보로 좌표값 변환 객체로 저장
										var convertChange = new Tmapv2.LatLng(
												convertPoint._lat,
												convertPoint._lng);
										// 배열에 담기
										drawInfoArr.push(convertChange);
									}
								} else {
									var markerImg = "";
									var pType = "";
									var size;
									if (properties.pointType == "S") { //출발지 마커
										markerImg = "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_s.png";
										pType = "S";
										size = new Tmapv2.Size(24, 38);
									} else
										(properties.pointType == "E")
									{ //도착지 마커
										markerImg = "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_e.png";
										pType = "E";
										size = new Tmapv2.Size(24, 38);
									}
									// 경로들의 결과값들을 포인트 객체로 변환 
									var latlon = new Tmapv2.Point(
											geometry.coordinates[0],
											geometry.coordinates[1]);
									// 포인트 객체를 받아 좌표값으로 다시 변환
									var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
											latlon);
								}
							}//for문 [E]
							drawLine(drawInfoArr); // 경로 그리기
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n"
									+ "message:" + request.responseText + "\n"
									+ "error:" + error);
						}
					});
		}
		// 지도 레벨 맞추기 (풀발 좌표를 받아서 지도 레벨을 맞춤)
		PTbounds = new Tmapv2.LatLngBounds();
		for (var ii = 0; ii < spl_num; ii++) {
			var linePt = new Tmapv2.LatLng(startPlaceList_y[ii],
					startPlaceList_x[ii]);
			PTbounds.extend(linePt);
		}
		map.fitBounds(PTbounds);
		
		// 마커 클릭 이벤트 마크 수 만큼 생성 함수
		function eplmarkerevent(i) {

			for (var j = 1; j < epl_num; j++) {
				markerevent(j);
			}

		}

		function markerevent(i) { // 마커 클릭 단일 이벤트 함수
			
			marker_e[i].addListener("click", function(evt) {
				$("#loc" + i).click();
			});
		
		}


		
		// 마크 클릭 확대 및 넘어가는 값 저장
		function remarker(i) {
			for (var j = 1; j < epl_num; j++) {
				marker_e[j].setMap(null);
				marker_e[j] = new Tmapv2.Marker(
						{
							position : new Tmapv2.LatLng(endPlaceList_y[j],
									endPlaceList_x[j]),
							icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_g_m_r.png",
							title : endPlaceList_name[j],
							//        	                   iconSize : new Tmapv2.Size(20, 30),
							map : map
						});
			}
			marker_e[i].setMap(null);
			marker_e[i] = new Tmapv2.Marker(
					{
						position : new Tmapv2.LatLng(endPlaceList_y[i],
								endPlaceList_x[i]),
						icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_r.png",
						title : endPlaceList_name[i],
						iconSize : new Tmapv2.Size(32, 50),
						map : map
					});
			eplmarkerevent(0); //  새로 그려진 마크에 클릭함수 
			$('#selected_x').attr('value', endPlaceList_x[i]);
			$('#selected_y').attr('value', endPlaceList_y[i]);
			$('#selected_name').attr('value', endPlaceList_name[i]);
		}
		// 경로 그리는 함수
		function drawLine(arrPoint) {
			var polyline_;
			polyline_ = new Tmapv2.Polyline({ // 경로 그리기
				path : arrPoint,
				strokeColor : "#DD0000",
				strokeWeight : 6,
				map : map
			});
			resultdrawArr.push(polyline_);
		}
	</script>

</body>

</html>
