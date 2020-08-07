<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head profile="http://www.w3.org/2005/10/profile">
<link rel="icon" type="image/png" href="http://example.com/myicon.png">
<meta charset="UTF-8">
<title>사용자 화면</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>
$(document).ready(function(){
	
	$("#addFri").click(function(){
		$("#adddiv").toggle();
	});
	
	//07.31 김재성 =======시작==================
	$('#friendlist').append(tag);
});

//친구목록 받아오기(from 컨트롤러)
var fl = '${friend_List}'.split("#");
var tag =""; //20라인에서 append될 태그 변수
for(var i=0; i<fl.length-1; i++){
	//태그 쌓기
	tag +='<tr><td class="registered">'+fl[i]
		+'</td><td><input type="button" data-email="'+fl[i]+'" value="삭제" onclick="delf(this)"/>'
		+ '</td><td>[!]</td></tr>';
}

function up(btn){
	var friendEmail = $(btn).data('email');
	var newFriend = '<tr><td class="registered">'+friendEmail+'</td><td>'+
					'<input type="button" data-email="'+friendEmail+
					'" value="삭제" onclick="delf(this)"/>'+
					'</td><td>[!]</td></tr>';
	var flag =true;
	//등록된 친구들 중에
	$('.registered').each(function(){
		if(friendEmail == $(this).text()){
			flag =false;
		}
	});
	
	if(flag){
		$("#friendlist").append(newFriend);	
	}else{
		alert("이미 추가된 친구입니다.");
		return false;
	}
	var myEmail = '${sessionScope.email}';
	$.ajax({
        type:"POST",
        url:"friend_add.do",
        data: {
        	"email2":friendEmail,
        	"email1" : myEmail
        	},
        dataType:'text', 
        success: function (data) {
        	//alert("return success="+data);       	
        }
        ,
    	  error:function(e){
    		  alert("data error"+e);
    	  }
      });
}
//07.31 김재성 =======끝==================
//친구 삭제 --------------------------------------------------
function delf(btn2){
	var friendEmail = $(btn2).data('email');
	$.ajax({
        type:"POST",
        url:"friend_del.do",
        data: {"email": friendEmail},
        dataType:'text',
        success: function (data) {
        	/* alert("return success="+data); */
        	
        	item = $(btn2).closest('tr');
        	item.remove();
        }
        ,
    	  error:function(e){
    		  alert("data error"+e);
    	  }
      });
}
//친구 삭제 --------------------------------------------------
//email duplicate check
function validate_useremail(val)
{
  var pattern= new RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
    
  //regular expression
  return pattern.test(val);
};

function email_check(){
	/* $("#searchResult").hide(); *///span area
	var email=$("#email").val();
	//verification
	if(!(validate_useremail(email))){
		var newtext='<font color="red">전자우편 형식 오류</font>';
		$("#searchResult").text(''); 
		$("#searchResult").show();	//span id area
		$("#searchResult").append(newtext);
		$("#email").val("").focus();
		return false;
	};
	

	//email duplicate check
    $.ajax({
        type:"POST",
        url:"friend_search.do",
        data: {"email":email},
        dataType:'text', 
        success: function (data) {
        	//alert("return success="+data); 
        	if(data==""){
        		alert("그런 사람 없어요");
        	}else{
        		var obj = JSON.parse(data);	
            	
            	$("#searchResult").empty()
            	$("#searchResult").append(
            			"<tr><td>전자우편</td>	<td>별명</td></tr>" + 
            			"<tr>" + "<td>" 
            			+ obj.email + "</td>" + "<td>" 
            			+ obj.nickname + "</td>" + "<td>" 
            			+ "<input type='button' data-email='"+obj.email+"' value='선택' onclick='up(this)'/>" 
            			+ "</td>" + "</tr>"); 
        	}
        }
        ,
    	  error:function(e){
    		  alert("data error"+e);
    	  }
      });//$.ajax
};

</script>

<style>
#adddiv {
	display: none;
}
</style>

</head>
<body>

	<c:if test="${sessionScope.email == null }">
		<script>
	alert("세션이 없습니다.");
	location.href="<%=request.getContextPath()%>/member_login.do";
		</script>
	</c:if>

	<c:if test="${sessionScope.email != null }">
		<div>

			${nickname}<br>
			<br>

			<div id="friendlist"></div>



			<!-- <table id="friend" width="300">
<tr><td colspan=2>친구</td>
</tr>
<tr><td>별명</td>
	<td>[+]</td>
</tr>
</table>
<br> -->



			<form method="post" action="member_logout.do">

				<input type="button" id="addFri" value="친구추가하기" />
				<div id="adddiv">
					<input type="text" id="email" placeholder="전자우편 입력"> <input
						type="button" value="친구찾기" onclick="email_check()" />

					<table id="searchResult" width="300">
					</table>
				</div>

				<br> <input type="button" value="정보수정" class="input_button"
					onclick="location='member_edit.do'" /> <br> <input
					type="button" value="계정삭제" class="input_button"
					onclick="location='member_del.do'" /> <br> <input
					type="submit" value="접속종료" class="input_button" />


			</form>
		</div>
	</c:if>

</body>
</html>
