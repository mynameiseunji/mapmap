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
	$('.btn.btn-dark').click(function() {
		var keyword = $("#addr1").val();		
		if(keyword.trim() == ""){
			alert("검색어를 입력해주세요.");
			return false;
		}
		// option으로 검색량 조절하기.
		places.keywordSearch(keyword, callback, options);
	});
});
var search_type ="keyword";
// api 에서 데이터 받아오고 modal에 보여주기.
var callback = function(result, status) {
	if (status === kakao.maps.services.Status.OK) {
		// console.log(search_type);
		$("#table_part tbody").empty();
		console.log(result);
		for ( var i in result) {
			
			var p_name = "";
			if(search_type=='keyword'){
				p_name=result[i].place_name;
			}else{	// search_type='geo'
				p_name=result[i].address_name;
			}		
			
			var str = "<tr><td class='btn'>" + p_name + "<br>"
			+ "<p class=w3-opacity style='font-size: 12px'>"
			+ result[i].address_name + "</p>"
			+ "<input name='hh' type='hidden' "
			+ "data-name='" + p_name + "' data-x='" + result[i].x
			+ "' data-y='" + result[i].y + "' data-addr='"
			+ result[i].address_name
			+ "'></td></tr>";

				
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
// ============================================================================


// modal에서 주소 선택했을 때 클릭 이벤트(joinform.jsp)======================================
/*function down(btn) {
	var name = $(btn).data("name");
	var x = $(btn).data("x");
	var y = $(btn).data("y");
	var addr_name = $(btn).data("addr");
	
	var tag ='<li class="w3-bar"><span onclick="this.parentElement.style.display=\'none\'"'+
						'class="w3-bar-item w3-button w3-white w3-xlarge w3-right">×</span>'+
						'<div class="w3-bar-item"><span class="w3-large">'+name+
						'</span><br> <span class="w3-addr">'+addr_name+
						'</span></div></li>';
	$('.w3-ul.w3-card-4').html(tag);
	
	$('input[name="addr1"]').attr('value',addr_name);
	$('input[name="x_"]').attr('value',x);
	$('input[name="y_"]').attr('value',y);
	$('button.close').click();
}*/
// ==========================================================================

// 20/08/11 권은지 주소 선택 변경
// =========================================================================
// 20/08/10 권은지 추가 : modal에서 주소 선택했을 때 클릭
// 이벤트=======================================================================
// 동적으로 생성되는 modal-body 테이블에서 값을 읽어오기 위해 바뀐 함수
$(document).on('click','td.btn', function(){
	console.log(this);
	var name = $(this).find("input[name=hh]").data('name');
	var x = $(this).find("input[name=hh]").data('x');
	var y = $(this).find("input[name=hh]").data('y');
	var addr_name = $(this).find("input[name=hh]").data('addr');

		
	var tag ='<li class="w3-bar"><span onclick="this.parentElement.style.display=\'none\'"'+
	'class="w3-bar-item w3-button w3-white w3-xlarge w3-right">×</span>'+
	'<div class="w3-bar-item"><span class="w3-large">'+name+
	'</span><br> <span class="w3-addr">'+addr_name+
	'</span></div></li>';
	$('.w3-ul.w3-card-4').html(tag);

	$("#form").append(str); // 데이터 넘기기위해 input type hidden으로 append
	$('input[name="addr1"]').attr('value',addr_name);
	$('input[name="x_"]').attr('value',x);
	$('input[name="y_"]').attr('value',y);
	$('button.close').click();
	
});
// ==============================================================================
// =========================================================================



 function check(){
	 if($.trim($("#email").val())==""){
		 alert("전자우편 입력");
		 $("#email").val("").focus();
		 return false;
	 }
	 if($.trim($("#pwd").val())==""){
		 alert("비밀번호 입력");
		 $("#pwd").val("").focus();
		 return false;
	 }
	 if($.trim($("#pwd2").val())==""){
		 alert("비밀번호 다시 입력");
		 $("#join_pwd2").val("").focus();
		 return false;
	 }
	 if($.trim($("#pwd").val()) != $.trim($("#pwd2").val())){
		 alert("비밀번호 불일치");
		 $("#pwd").val("");
		 $("#pwd2").val("");
		 $("#pwd").focus();
		 return false;
	 }
	 if($.trim($("#nickname").val())==""){
		 alert("별명 입력");
		 $("#nickname").val("").focus();
		 return false;
	 }
	 if($.trim($("#addr1").val())==""){		 
		 alert("주소 입력");
		 $("#addr1").val("").focus();
		 return false;
	 } 	 
 }
 
// email duplicate check
function email_check(){
	$("#emailcheck").hide();// span area
	var email=$("#email").val();
	// verification
	if(!(validate_useremail(email))){
		var newtext='<font color="red">이메일 형식 오류</font>';
		$("#emailcheck").text('');	
		$("#emailcheck").show();	// span id area
		$("#emailcheck").append(newtext);
		$("#email").val("").focus();
		return false;
	};
	

	// email duplicate check
    $.ajax({
        type:"POST",
        url:"member_emailcheck.do",
        data: {"email":email},        
        success: function (data) { 
        	/* alert("return success="+data); */
      	  if(data==1){	// id exists
      		var newtext='<font color="red">중복된 이메일입니다.</font>';
      			$("#emailcheck").text('');
        		$("#emailcheck").show();
        		$("#emailcheck").append(newtext);
          		$("#email").val('').focus();
          		return false;
	     
      	  }else{		// id not exists
      		var newtext='<font color="blue">사용 가능 이메일입니다.</font>';
      		$("#emailcheck").text('');
      		$("#emailcheck").show();
      		$("#emailcheck").append(newtext);
      		$("#email").focus();
      	  }  	    	  
        }
        ,
    	  error:function(e){
    		  alert("data error"+e);
    	  }
      });// $.ajax
};


function validate_useremail(mail)
{
  var pattern= new RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
    
  // regular expression
  return pattern.test(mail);
};


// editform.jsp에서 사용================================================
function edit_check(){
	if($.trim($("#pwd").val())==""){
		 alert("비밀번호 입력");
		 $("#join_pwd1").val("").focus();
		 return false;
	 }
	 if($.trim($("#nickname").val())==""){
		 alert("별명 입력");
		 $("#join_name").val("").focus();
		 return false;
	 }
	 if($.trim($("#addr1").val())==""){
		 alert("주소 입력");
		 $("#addr").val("").focus();
		 return false;
	 }
}

/*
 * // delform.jsp ==========================================================
 * function del_check(){ if($.trim($("#pwd").val())==""){ alert("비밀번호 입력");
 * $("#pwd").val("").focus(); return false; } }
 */
 