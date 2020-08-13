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

<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-3.5.0.js"></script> 
<!-- T맵 api -->
<script
   src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx45b1d9cc7eb14ee98cb9d6aca431df5e"></script>

</head>
<body>
   <!-- Navbar (sit on top) -->
   <div class="w3-top w3-light-blue">
      <div class="w3-bar w3-white w3-padding w3-card"
         style="letter-spacing: 4px;">
         <a href="index.jsp" class="w3-bar-item w3-button">Woori Jigum Manna</a>
         <!-- Right-sided navbar links. Hide them on small screens -->
         <div class="w3-right w3-hide-small">
            <a href="loginform.jsp" class="w3-bar-item w3-button">Sign In</a> <a
               href="joinform.jsp" class="w3-bar-item w3-button">Sign Up</a>
         </div>
         <div class="w3-right w3-hide-large w3-hide-medium">
            <a href="login.jsp" class="w3-bar-item w3-button">
            <i class="fa fa-user-circle fa-lg" aria-hidden="true">
            </i></a>
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
<!--          <a class="nav-link active" -->
<!--             data-toggle="tab" href="#home" onclick="drawmap(1)">location1</a> -->
            </li>
         
      </ul>
      </div>
      <form method="get" action="category.do" >
      <input type="hidden" id="selected_x" name="x" value="">
      <input type="hidden" id="selected_y" name="y" value="">
      <input type="hidden" id="selected_name" name="name" value="">
      <div class="tab-content">
         <div class="tab-pane container active" id="home">
         </div>
      
      </div>
     <button type="button" id="center1" class="btn btn-dark" onclick = "centerf">중심</button>
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
   // 
   
      //각 장소에대한 친구들의 경로 정보  => 장소1까지 친구1읠 경로/장소1까지 친구2의 경로/...
      var path_list = '${pathInfo}'.split('/');
      
      path_list.pop();console.log(path_list);	
      //출발지 갯수
      var x_num = parseInt('${x_num}');
      console.log(x_num)//3
      //파싱된 경로가 저장될 배열
      var times = new Array();
      //각 도착지에 대한 친구들의 정보 종합.
      for(var i=0; i<path_list.length/x_num; i++){
         var str = "";
         for(var j=0; j<x_num; j++){
        	
            if(path_list[j*x_num+j]==""){
               str +='<p>출발지 '+(j+1)+'번 예상 이동시간(도보) : ? 분</p>';
            }else{
            	var path_arr = path_list[i*x_num+j].split('#');
            	time = path_arr[path_arr.length-2];
            	
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
      
      //맨처음 보일 endplace를 html형식으로 append.
      // .tab-content 자손태그로 추가
//       var posi_li_active = '<h1>'+endPlaceList[0]+'</h1>'+
//                paths[0]+
//                '<span data-x="'+endPlaceList[1]+'" data-y="'+endPlaceList[2]+'"></span>';
      //append.
      var cen = 'center';
      $('#selected_x').attr('value',endPlaceList_x[0]);
      $('#selected_y').attr('value',endPlaceList_y[0]);
      $('#selected_name').attr('value',endPlaceList_name[0]);
      
//       $('#home').append(posi_li_active);
//       $('.nav-link.active').text(endPlaceList[0]); // location1 => 장소명으로 변경
      
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
					         '<a class="nav-link" data-toggle="tab" href="#menu'+i+
					         '" onclick="drawmap('+(i+1)+'); choice(this);">'+
					         endPlaceList_name[i]+'</a></li>';
         
         
         $('.tab-content').append(posi_li_fade);
         $('.nav.nav-tabs').append(posi_li_nav);
      }
      function centerf(btn){
         $('#selected_x').attr('value',endPlaceList_x[0]);
         $('#selected_y').attr('value',endPlaceList_y[0]);
         $('#selected_name').attr('value',cen);
      }
      
      function choice(btn){
         //console.log($(btn).closest('div').children('span').data('x'));
         var coor_x = $(btn).closest('li').children('span').data('x');
         var coor_y = $(btn).closest('li').children('span').data('y');
         var pname= $(btn).closest('li').children('span').data('name');
         $('#selected_x').attr('value',coor_x);
         $('#selected_y').attr('value',coor_y);
         $('#selected_name').attr('value',pname);
      };
      // 추천 후보지 보여주고 최종 좌표 값 다음 페이지로 넘기는 코드 ==== 끝 ===========================
   
	
      var startPlaceList_x = '${startPlaceList_x}'.split("#");
      var startPlaceList_y = '${startPlaceList_y}'.split("#")
      var startPlaceList_name = '${startPlaceList_name}'.split("#")
      startPlaceList_x.pop();startPlaceList_y.pop();startPlaceList_name.pop();
      var spl_num = startPlaceList_x.length;
      
      // 출발지 마커 좌표와 이름 
     
      
      //마커 이미지의 이미지 주소입니다
      
      
      
      drawmap(0);
      function drawmap(i){
         
         $("#map_div").empty();
         var endX = endPlaceList_x[i];
         var endY = endPlaceList_y[i];
         // 1. 지도 띄우기
         var map = new Tmapv2.Map("map_div", { //map2 로 만듬
         center : new Tmapv2.LatLng(endY, endX),

         width : "80%",
         height : "50%"
      });
         var marker_s, marker_e, marker_p1, marker_p2;
         var totalMarkerArr = [];
         var drawInfoArr = [];
         var resultdrawArr = [];
         // 2. 시작, 도착 심볼찍기
         // 시작
         
         for(var i=0; i<startPlaceList_x.length; i++){
         marker_s = new Tmapv2.Marker(
               {
                  position : new Tmapv2.LatLng(startPlaceList_y[i], startPlaceList_x[i]),
                  icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
                  iconSize : new Tmapv2.Size(24, 38),
                  map : map
               });
         }

         // 도착
         marker_e = new Tmapv2.Marker(
               {
                  position : new Tmapv2.LatLng(endY, endX),
                  icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_e.png",
                  iconSize : new Tmapv2.Size(24, 38),
                  map : map
               });

         
         // 4. 경로탐색 API 사용요청
         for (var t = 0; t < startPlaceList_x.length; t++) {
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
                     endX : endX,
                     endY : endY,
                     
                     reqCoordType : "WGS84GEO",
                     resCoordType : "EPSG3857",
                     startName : "출발지",
                     endName : "도착지"
                  },
                  success : function(response) {
                     var resultData = response.features;

                     //결과 출력
                     var tDistance = "총 거리 : "
                           + ((resultData[0].properties.totalDistance) / 1000)
                                 .toFixed(1) + "km,";
                     var tTime = " 총 시간 : "
                           + ((resultData[0].properties.totalTime) / 60)
                                 .toFixed(0) + "분";

                     

                     
                     drawInfoArr = [];

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
                           } else if (properties.pointType == "E") { //도착지 마커
                              markerImg = "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_e.png";
                              pType = "E";
                              size = new Tmapv2.Size(24, 38);
                           } else { //각 포인트 마커
                              markerImg = "http://topopen.tmap.co.kr/imgs/point.png";
                              pType = "P";
                              size = new Tmapv2.Size(8, 8);
                           }

                           // 경로들의 결과값들을 포인트 객체로 변환 
                           var latlon = new Tmapv2.Point(
                                 geometry.coordinates[0],
                                 geometry.coordinates[1]);

                           // 포인트 객체를 받아 좌표값으로 다시 변환
                           var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
                                 latlon);

                           var routeInfoObj = {
                              markerImage : markerImg,
                              lng : convertPoint._lng,
                              lat : convertPoint._lat,
                              pointType : pType
                           };

                           // Marker 추가
                           marker_p = new Tmapv2.Marker(
                                 {
                                    position : new Tmapv2.LatLng(
                                          routeInfoObj.lat,
                                          routeInfoObj.lng),
                                    icon : routeInfoObj.markerImage,
                                    iconSize : size,
                                    map : map
                                 });
                        }
                     }//for문 [E]
                     drawLine(drawInfoArr);
                  },
                  error : function(request, status, error) {
                     console.log("code:" + request.status + "\n"
                           + "message:" + request.responseText + "\n"
                           + "error:" + error);
                  }
               });
         }
      

      function addComma(num) {
         var regexp = /\B(?=(\d{3})+(?!\d))/g;
         return num.toString().replace(regexp, ',');
      }
      
      function drawLine(arrPoint) {
         var polyline_;

         polyline_ = new Tmapv2.Polyline({
            path : arrPoint,
            strokeColor : "#DD0000",
            strokeWeight : 6,
            map : map
         });
         resultdrawArr.push(polyline_);
      }
      PTbounds = new Tmapv2.LatLngBounds();
      for (var ii = 0; ii < startPlaceList_x.length; ii++) {
         var linePt = new Tmapv2.LatLng(startPlaceList_y[ii],startPlaceList_x[ii]);
//          console.log(linePt);
         PTbounds.extend(linePt);
      }
      map.fitBounds(PTbounds);
}
      
   </script>      
      
      
      

   <%-- <!-- 08/03 권은지 : 추천 지하철 역 테스트용 코드 -->
   <table border="1">
      <thead>
         <th>역이름</th>
         <th>xs</th>
         <th>ys</th>
      </thead>
      <tbody>
         <c:forEach items="${rcm_stationList}" var="rcm">
            <tr>
               <td>${rcm.subname}</td>
               <td>${rcm.xs}</td>
               <td>${rcm.ys}</td>
            </tr>
         </c:forEach>
      </tbody>
   </table> --%>
</body>

</html>
