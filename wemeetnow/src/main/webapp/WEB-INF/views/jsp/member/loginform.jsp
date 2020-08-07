<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
}
</script>
<body>

	<!-- Navbar (sit on top) -->
	<div class="w3-top w3-light-blue">
		<div class="w3-bar w3-white w3-padding w3-card"
			style="letter-spacing: 4px;">
			<a href="index.jsp" class="w3-bar-item w3-button">우리 지금 만나</a>
			<!-- Right-sided navbar links. Hide them on small screens -->
			<div class="w3-right w3-hide-small">
				<a href="joinform.do" class="w3-bar-item w3-button">회원 가입</a>
			</div>
			<div class="w3-right w3-hide-large w3-hide-medium">
				<a href="login.jsp" class="w3-bar-item w3-button"> <!-- ?????? 어디로 가는 코드? -->
				<i class="fa fa-user-circle fa-lg" aria-hidden="true">
				</i></a>
			</div>
		</div>
	</div>
	<div class='container-sm' style='margin-top: 80px'>
	<h1>로그인</h1>
	<br>
		<form action="member_login_ok.do" method="POST" onsubmit="return check()">
			<div class="form-group">
				<label for="email">이메일 주소 :</label> <input type="email"
					class="form-control" placeholder="이메일" name="email" id="email" required>
			</div>
			<div class="form-group">
				<label for="pwd">비밀 번호 :</label> <input type="password"
					class="form-control" name="pwd" placeholder="비밀번호" id="pwd">
			</div>
			<!--
			<div class="form-group form-check">
				<label class="form-check-label"> <input
					class="form-check-input" type="checkbox" required> Remember me
				</label>
			</div>
			-->
			<button type="submit" class="w3-button w3-white w3-border w3-border-gray w3-round-large">로그인</button>
			<button type="button" class="w3-button w3-white w3-border w3-border-gray w3-round-large" onclick="location.href='member_join.do'">회원 가입</button>
		</form>
	</div>
	<footer class="w3-center w3-light-grey w3-padding-32">
		<p>
			Powered by <a href="https://www.w3schools.com/w3css/default.asp"
				title="W3.CSS" target="_blank" class="w3-hover-text-green">w3.css</a>
		</p>
	</footer>
</body>
</html>