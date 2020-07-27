<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
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
	var keyword="";
	var places = new kakao.maps.services.Places();
	var search_type ="keyword";
	
	// 지도 중심위치 설정
	var latlng = new kakao.maps.LatLng(37.5668260054857, 126.978656785931);
	var options = {
			location : latlng
	};
	$(document).ready(function() {
		$('.btn-success').click(function() {
			keyword = $("#bt").val();
			if(keyword.trim() == ""){
				alert("검색어를 입력해주세요.");
				return false;
			}
			//option으로 검색량 조절하기.
			places.keywordSearch(keyword, callback, options);
		});
	});
	
	var callback = function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			console.log(search_type);
			$(".modal-body table").empty();
			for ( var i in result) {
				
				var p_name = "";
				if(search_type=='keyword'){
					p_name=result[i].place_name;
				}else{	//search_type='geo'
					p_name=result[i].address_name;
				}
				
				var str = "<tr><td>"+ p_name
						+ "<br>"+ result[i].address_name +
						"<input type='hidden' name='name' value='" + p_name +
						"'/><input type='hidden' name='x' value='" + result[i].x +
						"'/><input type='hidden' name='addr_name' value='"+ result[i].address_name +
						"'/><input type='hidden' name='y' value='" + result[i].y 
						+"'></td><td align='right'><input type='button' class='btn btn-info' onclick='down(this)' value='선택'></td></tr>";
				$(".modal-body table").append(str);
			}
		}else if(search_type=='keyword'){
			search_type="geo";
			var geocoder = new kakao.maps.services.Geocoder();
			return geocoder.addressSearch(keyword, callback);
		}else{
			$(".modal-body").empty();
			$(".modal-body").append("검색 결과가 없습니다.");
		}

		search_type="keyword";
	};	
	
	function down(btn) {
		item =$(btn).closest('tr');
		
		if ($('div.list input[name="x"]').length == 10) {
			alert("최대10개");
		} else {
			$(btn).attr('onclick','remove_addr(this)');
			$(btn).attr('value','삭제');
			$(btn).attr('class','btn btn-outline-danger btn-sm');
			
			var d = "<tr>"+item.html()+"</tr>";
			$('form div.list table').append(d);
			$('button.close').click();
		}
	}
	
	function remove_addr(it){
		$(it).closest('tr').remove();
		//var sel="div#sel"+num;
		//$(sel).empty();
	}
	// 	places.keywordSearch('판교 치킨', callback);
	
	
	//뒤로가기 이벤트 감지 코드
	// 참고 링크 :: https://dev-t-blog.tistory.com/9
	window.onpageshow = function(event) {
	    if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
			// Back Forward Cache로 브라우저가 로딩될 경우 혹은 브라우저 뒤로가기 했을 경우
			console.log("뒤로가기로 들어왔습니다.");
			location.reload();
	    }else{
	    	console.log("새로 진입");
	    }
	}
</script>
</head>
<body>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
	<a class="navbar-brand" href="#">Logo</a>
	<ul class="navbar-nav">
		<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
		<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
	</ul>
	</nav>
	<div class="container" align="center" style="margin-top:80px">
		<h2>주소 검색</h2>
		
		<!-- Button to Open the Modal -->
		<div class="input-group mb-3">
		<input type="text" id="bt" class="form-control" placeholder="placeholder">
		<div class="input-group-append">
		<button type="button" class="btn btn-success" data-toggle="modal"
			data-target="#myModal">Search</button>
		</div>
		</div>
		<!-- The Modal -->
		<div class="modal" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">주소 검색</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">
					<table class="table"></table>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>

				</div>
			</div>
		</div>
	</div>
	<br>
	<hr>
	<br>
	<div class="container" align="center">
		<form method='post' action="sendAddr.do">
			<div class="list">
			<table class="table">
				<!-- 세션 처리 위한 코드 07.24 김재성 -->
				<c:if test="${sessionScope._name != null}">
					<c:forEach var="name" items="${sessionScope._name}" varStatus="status">
						<tr>
						<td width="75%">${name}
						<br> ${sessionScope._addr[status.index]}
						<input type='hidden' name='name' value='${name}'/>
						<input type='hidden' name='addr_name' value='${sessionScope._addr[status.index]}'/>
						<input type='hidden' name='x' value='${sessionScope._x[status.index]}'/>
						<input type='hidden' name='y' value='${sessionScope._y[status.index]}'/></td>
						<td width="20%" align="right"><input type='button' class='btn btn-outline-danger btn-sm' onclick='remove_addr(this)' value='삭제'></td>
						</tr>
					</c:forEach>
				</c:if>
				</table>
			</div>
			<br>
			<input class="btn btn-block btn-info" type='submit' value='전송'>
		</form>
	</div>
</body>
</html>









