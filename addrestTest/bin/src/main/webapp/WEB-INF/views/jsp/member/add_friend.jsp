<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>
/* $(document).ready(function(){
    $("#button").click(function(){
        searchfriend();
    });
}); */


//email duplicate check
function validate_useremail(mememail)
{
  var pattern= new RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
    
  //regular expression
  return pattern.test(mememail);
};
function email_check(){
	$("#searchResult").hide();//span area
	var mememail=$("#email").val();
	//verification
	if(!(validate_useremail(mememail))){
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
        url:"member_emailcheck.do",
        data: {"mememail":mememail},        
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




/* $(document).ready(function(){
	//search friend
	$("#fSearch").click(function) {
		$("#searchResult").empty();
		$.ajax({
			type:"get",
			url:"search_friend.do="+$("#fEmail").val(),
			success: function(data){
				if(data==1){
					$("#searchResult").text('검색 결과 있음');
				}
				else{
					$("#searchResult").text('검색 결과 없음');	
				}
			}
		});
	}
};
	 */
	
	
	
	
	

</script>


</head>
<body>

<input type="text" id="email" placeholder="전자우편 입력" >
<input type="button" value="친구검색" onclick="email_check()"/>
<div id="searchResult">

XXX

</div>



</body>
</html>