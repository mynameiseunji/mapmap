// 출발지 검색에 사용됨(joinform.jsp)========================================
	var keyword="";
	var places = new kakao.maps.services.Places();	
	// 지도 중심위치 설정
	var latlng = new kakao.maps.LatLng(37.5668260054857, 126.978656785931);
	var options = {
			location : latlng,
			size : 5
	};
$(document).ready(function() {	
	
	
	$('#check_data').click(function() {
		console.log($('.place_values').length);
		if ($('.place_values').length < 2) {
			alert("주소지 정보를 2개 이상 입력해주세요");
			return false;
		}
		// controller에서 객체 리스트로 매핑하기위한 코드.
		// submit 버튼 눌렀을 때 작동하는 이벤트
		// name을 places[0].x,  places[0].y .. 처럼 설정해주면
		// controller에서 dto 리스트로 받을 수 있음
		// 참고  http://noveloper.github.io/blog/spring/2015/02/16/how-mapping-to-model-arrayvalue.html
		$("#form .place_values").each( function (index) {
        	$(this).find("input[name=x]").attr("name", "places[" + index + "].x");
        	$(this).find("input[name=y]").attr("name", "places[" + index + "].y");
        	$(this).find("input[name=name]").attr("name", "places[" + index + "].name");
        	$(this).find("input[name=address]").attr("name", "places[" + index + "].address");
    	})
    				
	});
	
	$('#search').click(function() {
		var keyword = $("#search_bar").val();		
		if(keyword.trim() == ""){
			alert("검색어를 입력해주세요.");
			return false;
		}
		//option으로 검색량 조절하기.
		places.keywordSearch(keyword, callback, options);
	});
});
var search_type ="keyword";
// api 에서 데이터 받아오고 modal에 보여주기.
var callback = function(result, status) {
	if (status === kakao.maps.services.Status.OK) {
		//console.log(search_type);
		$("#table_part tbody").empty();
		//console.log(result);
		for ( var i in result) {
			
			var p_name = "";
			if(search_type=='keyword'){
				p_name=result[i].place_name;
			}else{	//search_type='geo'
				p_name=result[i].address_name;
			}		
			
			var str = "<tr><td>"+p_name+"<br>"+
					"<p class=w3-opacity style='font-size: 12px'>"+
					result[i].address_name+"</p>" +
					"<input  type='button' class='btn btn-info'" +
					"' data-name='"+p_name+
					"' data-x='"+result[i].x+
					"' data-y='"+result[i].y+
					"' data-addr='"+result[i].address_name+
					"' onclick='down(this)' value='선택'></td></tr>";
			
			$("#table_part tbody").append(str);
			
		}
	}else if(search_type=='keyword'){
		search_type="geo";
		var geocoder = new kakao.maps.services.Geocoder();
		return geocoder.addressSearch(keyword, callback);
	}else{
		$("#table_part tbody").empty();
		$("#table_part tbody").append("검색 결과가 없습니다.");
	}
};
//============================================================================


//modal에서 주소 선택했을 때 클릭 이벤트(home.jsp)======================================
function down(btn) {
	var name = $(btn).data("name");
	var x = $(btn).data("x");
	var y = $(btn).data("y");
	var addr_name = $(btn).data("addr");
	
	var tag ='<li class="w3-bar"><span onclick="remove(this)" '+
						' data-x="'+x+
						'" class="w3-bar-item w3-button w3-white w3-xlarge w3-right">×</span>'+
						'<div class="w3-bar-item"><span class="w3-large">'+name+
						'</span><br> <span class="w3-addr">'+addr_name+
						'</span></div></li>';
	
	var str ="<div class='place_values'>"+
			"<input type='hidden' name='name' value='" + name +
			"'/><input type='hidden' name='x' value='" + x +
			"'/><input type='hidden' name='address' value='"+ addr_name +
			"'/><input type='hidden' name='y' value='" + y +"'></div>";
	
	$('.w3-ul.w3-card-4').append(tag);
	$("#form").append(str);
	$('button.close').click();
	$("#table_part tbody").empty();
}
//==========================================================================




// 선택된 출발지에서 삭제 버튼 누를 때 실행
function remove(it) {
	var x =$(it).data("x");
	var parent = $(it).closest("li").remove();
	var target = $('input[value="'+ x +'"]').closest('div').remove();
	//세션 낱개 삭제 가능???
}

//뒤로가기 이벤트 감지 코드
// 참고 링크 :: https://dev-t-blog.tistory.com/9
window.onpageshow = function(event) {
	if (event.persisted
			|| (window.performance && window.performance.navigation.type == 2)) {
		// Back Forward Cache로 브라우저가 로딩될 경우 혹은 브라우저 뒤로가기 했을 경우
		console.log("뒤로가기로 들어왔습니다.");
		location.reload();
	} else {
		console.log("새로 진입");
	}
}
 