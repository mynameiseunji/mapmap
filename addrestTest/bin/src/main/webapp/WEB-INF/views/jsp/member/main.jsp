<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 화면</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>
$(document).ready(function(){
	
$("p").click(function(){
	$("#adddiv").toggle();
});

});

//email duplicate check
function validate_useremail(mememail)
{
  var pattern= new RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
    
  //regular expression
  return pattern.test(mememail);
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
        url:"friendSearch.do",
        data: {"email":email},        
        success: function (data) { 
        	/*alert("return success="+data);*/
      	  if(data==1){	//id exists
      		var newtext='친구 정보 불러오기';
      			$("#searchResult").text('');
        		$("#searchResult").show();
        		$("#searchResult").append(newtext);
          		$("#email").val('').focus();
          		return false;
	     
      	  }else{		//id not exists
      		var newtext='검색 결과 없음';
      		$("#searchResult").text('');
      		$("#searchResult").show();
      		$("#searchResult").append(newtext);
      		$("#email").focus();
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
#adddiv {display: none;}
</style>

</head>
<body>

<c:if test="${sessionScope.email == null }"> 
  <script>
   alert("다시 접속");
   location.href="<%=request.getContextPath()%>/member_login.do";
  </script>
</c:if>

<c:if test="${sessionScope.email != null }">  
 
<div>

${nickname}

<br>
<form method="post" action="member_logout.do"> 

<p>친구추가</p>
<div id="adddiv">
<input type="text" id="email" placeholder="전자우편 입력" >
<input type="button" value="친구검색" onclick="email_check()"/>
</div>
 <!-- <input type="button" value="친구추가" class="input_button"
     		onclick="location='add_friend.do'" /> -->
<div id="searchResult">

</div>

<br>
<input type="button" value="정보수정" class="input_button" onclick="location='member_edit.do'" />
<br>
<input type="button" value="계정삭제" class="input_button" onclick="location='member_del.do'" />
<br>
<input type="submit" value="접속종료" class="input_button" />     
	
	
	
	
   </form>
 </div>
</c:if>

</body>
</html>