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
	
	$(document).ready(function() {
		$('.btn-primary').click(function() {
			keyword = $("#bt").val();
			if(keyword.trim() == ""){
				alert("검색어를 입력해주세요.");
				return false;
			}
			//option으로 검색량 조절하기.
			places.keywordSearch(keyword, callback);
		});
	});
	var search_type ="keyword";
	var callback = function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			console.log(search_type);
			$(".modal-body").empty();
			for ( var i in result) {
				
				var p_name = "";
				if(search_type=='keyword'){
					p_name=result[i].place_name;
				}else{	//search_type='geo'
					p_name=result[i].address_name;
				}
				
				var str = "<p>"+ p_name
						+ "<input type='hidden' name='name' value='" + p_name +
						"'/><input type='hidden' name='x' value='" + result[i].x +
						"'/><input type='hidden' name='addr_name' value='"+ result[i].address_name +
						"'/><input type='hidden' name='y' value='" + result[i].y 
						+"'><input type='button' class='btn btn-info' onclick='down(this)' value='선택'></p>";
				$(".modal-body").append(str);
			}
		}else if(search_type=='keyword'){
			search_type="geo"
			var geocoder = new kakao.maps.services.Geocoder();
			return geocoder.addressSearch(keyword, callback);
		}else{
			$(".modal-body").empty();
			$(".modal-body").append("검색 결과가 없습니다.");
		}
		search_type="keyword";
	};	
	
	function down(btn) {
		item =$(btn).closest('p');
		
		if ($('div.list input[name="x"]').length == 10) {
			alert("최대10개");
		} else {
			$(btn).attr('onclick','remove_addr(this)');
			$(btn).attr('value','삭제');
			
			var d = "<div class='sel' >" + item.html() + "</div>";
			$('form div.list').append(d);
			$('button.close').click();
		}
	}
	
	function remove_addr(it){
		$(it).closest('div').remove();
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

	<div class="container">
		<h2>Modal Example</h2>
		<!-- Button to Open the Modal -->
		<input type="text" id="bt">
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#myModal">Open modal</button>

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
					<div class="modal-body"></div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>

				</div>
			</div>
		</div>

	</div>
	<div class="container">
		<form method='post' action="sendAddr.do">
			<div class="list">
				<!-- 세션 처리 위한 코드 07.24 김재성 -->
				<c:if test="${sessionScope._name != null}">
					<c:forEach var="name" items="${sessionScope._name}" varStatus="status">
						<div class="sel">
						${name}
						<input type='hidden' name='name' value='${name}'/>
						<input type='hidden' name='addr_name' value='${sessionScope._addr[status.index]}'/>
						<input type='hidden' name='x' value='${sessionScope._x[status.index]}'/>
						<input type='hidden' name='y' value='${sessionScope._y[status.index]}'/>
						<input type='button' class='btn btn-info' onclick='remove_addr(this)' value='삭제'>
						</div>
					</c:forEach>
				</c:if>
			</div>
			<input type='submit' value='전송'>
		</form>
	</div>
</body>
</html>