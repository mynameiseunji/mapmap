<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<title>title</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
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
<script>
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
		var newtext='<li class="list-group-item"><font color="red">이메일 형식 오류</font></li>';
		$("#resultList").show();
		$("#resultList").empty();
		$("#resultList").append(newtext);
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
        	console.log(data)
        	if(data == ""){
        		alert("그런 아이디 없어요~")
       		}else{
       			
               	var obj = JSON.parse(data);	
               	var str = '<li class="list-group-item"><div class="w3-low"><div class="w3-col s10">Email : '
               			+ obj.email +'<br>Nickname : '+ obj.nickname + '</div><div class="w3-col s2 add">'
               			+ '</div></div></li>';
               	$("#resultList").show();
               	$("#resultList").empty();
               	$("#resultList").append(str);
               	
               	
               	var btn = '<span id="add_btn" class="w3-bar-item w3-button w3-white w3-xlarge w3-right">+</span>';
               	$(".add").append(btn);
               	
               	$("#add_btn").attr('onclick', 'add("'+obj.email+'")');
       		}
        	
        }
        ,
    	  error:function(e){
    		  alert("data error"+e);
    	  }
      });//$.ajax
};


function deleteCheck(num){
	console.log(num);
	var check = confirm('Delete Confirm');
	console.log(check);
	if(check){		
		location.href="<%=request.getContextPath()%>/friend_del.do?fno="+num;
	}
}

function add(email){
	console.log(email);
	var check = confirm('add Confirm');
	console.log(check);
	if(check){
		$.ajax({
	        type:"POST",
	        url:"friend_add.do",
	        data: {"email":email},
	        success: function (data) {

	        	if(data==-1){		
	        		alert("이미 등록된 친구")
	        		return false;
	        	} else {
		      		location.href="<%=request.getContextPath()%>/friendlist.do";
	        	}  		
	        }	    	
	        ,
	    	error:function(e){
	    		alert("data error"+e);
	    	}
		});//$.ajax
	}	
}

$(document).ready(function(){
	$('#resultList').hide();
});
</script>
<body>

	<!-- Navbar (sit on top) -->
	<div class="w3-top w3-light-blue">
		<div class="w3-bar w3-white w3-padding w3-card"
			style="letter-spacing: 4px;">
			<a href="index.jsp" class="w3-bar-item w3-button">Woori Jigum
				Manna</a>
			<!-- Right-sided navbar links. Hide them on small screens -->
			<div class="w3-right w3-hide-small">
				<a href="member_logout.do" class="w3-bar-item w3-button">로그 아웃</a> <a
					href="member_info.do" class="w3-bar-item w3-button">회원 정보</a>
			</div>
			<div class="w3-right w3-hide-large w3-hide-medium">
				<a href="member_info.do" class="w3-bar-item w3-button"> <i
					class="fa fa-user-circle" aria-hidden="true"> </i></a>
			</div>
		</div>
	</div>
	<div class='container-sm' style='max-width: 500px; margin-top: 80px'
		align="left">
		<h1>Friend List</h1>
		<br>
		<ul class="list-group">
			<c:forEach var="friend" items="${list}" varStatus="status">
				<li class="list-group-item">
					<div class="w3-low">
						<div class="w3-col s10">
							Email : ${friend.email2 }<br>addr : address..............
						</div>
						<div class="w3-col s2">
							<span onclick="deleteCheck(${friend.fno})"
								class="w3-bar-item w3-button w3-white w3-xlarge w3-right">x</span>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
		<br> <br>
		<div class="w3-row">
			<div class="w3-col w3-center">
				<form>
					<input type="text" id="email">
					<button type="button" class="btn btn-outline-dark"
						onclick="email_check()">Search Friend</button>
				</form>
			</div>
		</div>
	</div>
	<div id="searchResult" class="container-sm"
		style='max-width: 500px; margin-top: 20px'>
		<ul id="resultList" class="list-group">

		</ul>
	</div>
	<footer class="w3-center w3-light-grey w3-padding-32">
		<p>
			Powered by <a href="https://www.w3schools.com/w3css/default.asp"
				title="W3.CSS" target="_blank" class="w3-hover-text-green">w3.css</a>
		</p>
	</footer>
</body>
</html>


