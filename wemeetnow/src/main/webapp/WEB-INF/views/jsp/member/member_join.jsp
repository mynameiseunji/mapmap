<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 가입</title>

<!-- <script src="/springmember/js/jquery.js"></script> -->
<script src="<%=request.getContextPath()%>/js/member.js"></script>
	

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
		item =$(btn).closest('tr td');
		
		if ($('input.addr input[name="x"]').length == 1) {
			alert("이미 주소가 있습니다. 삭제하시고 추가해주세요");
		} else {
			$(btn).attr('onclick','remove_addr(this)');
			$(btn).attr('value','삭제');
			$(btn).attr('class','btn btn-outline-danger btn-sm');
			
			var d = "<tr>"+item.html()+"</tr>";
			$('input.addr').append(d);
			$('button.close').click();

		}
		$('#addr').attr('value',$('input[name="addr_name"]').attr('value'));
		$('#lon').attr('value',$('input[name="x"]').attr('value'));
		$('#lat').attr('value',$('input[name="y"]').attr('value'));
	}
	
	function remove_addr(it){
		$(it).closest('div').remove();
		//var sel="div#sel"+num;
		//$(sel).empty();
	}

</script>
</head>
<body>

 <div >
  <h3>회원가입</h3>
  <form name="f" method="post" action="member_join_ok.do" onsubmit="return check()">
 
   <table>
    <tr>
     <th>전자우편</th>
     <td>
      <input name="email" id="email" class="input_box" />
      <input type="button" value="전자우편 중복확인" class="input_button" onclick="email_check()" />
      <div id="emailcheck"></div>
     </td>
    </tr>
    
    <tr>
     <th>비밀번호</th>
     <td>
      <input type="password" name="pwd" id="pwd1" class="input_box" />
     </td>
    </tr>
    
    <tr>
     <th>비밀번호확인</th>
     <td>
      <input type="password" name="pwd2" id="pwd2" class="input_box" />
     </td>
    </tr>
    
    <tr>
     <th>별명</th>
     <td>
      <input name="nickname" id="nickname" class="input_box" />
     </td>
    </tr>
       
    <tr>
     <th>주소</th>
     <td>
		<!-- Button to Open the Modal -->
		<input type="text" id="bt" class="form-control" placeholder="placeholder">
	</td>
	<td>
		<button type="button" class="btn btn-success" data-toggle="modal"
			data-target="#myModal">Search</button>
			 <!-- The Modal -->
		
	</td>

	<td>
		<input name="addr" id="addr" class="input_box" readonly />
		<input name="lon" id="lon" class="input_box"  />
		<input name="lat" id="lat" class="input_box"  />
			
     </td>
    </tr>

   </table>
   
   <div>
    <input type="button" value="이전화면" class="input_button" style="width:80px" 
    onclick="history.go(-1)" />
    <input type="submit" value="회원가입" class="input_button" style="width:80px" />
   </div>
  </form>
 </div>
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
</body>
</html>
