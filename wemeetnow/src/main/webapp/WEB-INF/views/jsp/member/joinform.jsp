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
<!-- 카카오 api 연결-->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b6c81e5d496e486ca93f4d82d0a0027&libraries=services"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="<%=request.getContextPath()%>/js/join.js"></script>
<script >

</script>
<body>

	<!-- Navbar (sit on top) -->
	<div class="w3-top w3-light-blue">
		<div class="w3-bar w3-white w3-padding w3-card"
			style="letter-spacing: 4px;">
			<a href="index.jsp" class="w3-bar-item w3-button">우리 지금 만나</a>
			<!-- Right-sided navbar links. Hide them on small screens -->
			<div class="w3-right w3-hide-small">
				<a href="member_login.do" class="w3-bar-item w3-button">로그인</a> <a
					href="member_join.do" class="w3-bar-item w3-button">회원가입</a>
			</div>
			<div class="w3-right w3-hide-large w3-hide-medium">
				
				<!-- login.jsp  여기 어디?-->
				
				<a href="login.jsp" class="w3-bar-item w3-button">
				<i class="fa fa-user-circle fa-lg" aria-hidden="true">
				</i></a>
			</div>
		</div>
	</div>
	<div class='container-sm' style='margin-top: 80px'>
		<h1>회원 가입</h1>
		<form action="member_join_ok.do" method="post" onsubmit="return check()">
			<!-- 컨트롤로 넘길 값 -->
			<input type="hidden" name="addr1" value="">
			<input type="hidden" name="x_" value="">
			<input type="hidden" name="y_" value="">
			
			<div class="form-group">
				<label for="email">이메일 주소 : </label> <input type="email"
					class="form-control" placeholder="이메일" name="email" id="email" required>
					<input type="button" value="이메일 중복확인" class="input_button" onclick="email_check()" />
					<div id="emailcheck"></div>
			</div>
			<div class="form-group">
				<label for="pwd">비밀 번호 : </label> <input type="password"
					class="form-control" placeholder="비밀번호" name="pwd" id="pwd" required>
			</div>
			<div class="form-group">
				<label for="pwd">비밀번호 확인 : </label> <input type="password"
					class="form-control" placeholder="비밀번호 재입력" id="pwd2" required>
			</div>
			<div class="form-group">
				<label for="name">닉네임 :</label> <input type="text"
					class="form-control" placeholder="별명" name="nickname" id="nickname" required>
			</div> 
			
			<label for="addr">출발지 검색 :</label>
			<div class="input-group mb-3 form-group">
				<input type="text" id="addr1" class="form-control"
					placeholder="검색할 주소를 입력하세요" >
				<div class="input-group-append">
					<button type="button" class="btn btn-dark" data-toggle="modal"
						data-target="#myModal">검색</button>
					<br>
				</div>

			</div>

			<!-- The Modal -->
			<div class="modal" id="myModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">
								<b>&nbsp;&nbsp;Result</b>
							</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body" style='font-size: 18px'>
							<table id="table_part" class="w3-table w3-bordered w3-hoverable">
								<tbody wdith="100%">
									<!-- 카카오 api 검색 결과가 들어갈 자리 -->
								</tbody>
							</table>
						</div>


					</div>
				</div>
			</div>

			<div class="container-sm"
				style="margin-top: 15px; margin-bottom: 15px">
				<ul class="w3-ul w3-card-4">
					<!-- 사용자가 선택한 출발지가 들어갈 자리 -->
				</ul>
			</div>
			<button type="submit"
				class="w3-button w3-white w3-border w3-border-gray w3-round-large">Submit</button>
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