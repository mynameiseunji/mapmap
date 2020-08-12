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
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
	font-family: 'Nanum Gothic', sans-serif;
}

p.station {
	
}

h1, h2, h3, h4, h5, h6 {
	font-family: 'Nanum Gothic', sans-serif;
	letter-spacing: 5px;
}

.col {
	padding: 10px;
}
</style>
<script defer src="./all.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script>
	/* if('${startPlaceList}'==""){
		alert("세션이 없습니다.")
		location.href="test.do"
	} */
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
				<a href="loginform.jsp" class="w3-bar-item w3-button">Sign In</a> <a
					href="joinform.jsp" class="w3-bar-item w3-button">Sign Up</a>
			</div>
			<div class="w3-right w3-hide-large w3-hide-medium">
				<a href="login.jsp" class="w3-bar-item w3-button"> <i
					class="fa fa-user-circle fa-lg" aria-hidden="true"> </i></a>
			</div>
		</div>
	</div>
	<div class="container-sm table-responsive" style="margin-top: 80px">
		<div class="w3-row">
			<div class="w3-col s6" align="left">
				<h1>Route</h1>
			</div>
			<div class="w3-col s6" align="right">
				<button class="btn btn-outline-warning">공유공유</button>
			</div>
		</div>
		<table class="table">
			<tr align=center>
				<th>출발</th>
				<th colspan=2>경로</th>
				<th>시간</th>
			</tr>
			<tr>
				<td style="vertical-align: middle; text-align: center"><i
					class="fas fa-user-alt fa-2x"></i>
					<p>Joon</p>
					<p>(출발위치)</p></td>
				<td width="70px">

					<p class="station">
						<i class="fas fa-subway"></i>
					</p>
					<p class="station">
						<i class="fas fa-bus"></i>
					</p>
					<p class="station">
						<i class="fas fa-subway"></i><b>+</b><i class="fas fa-bus"></i>
					</p>
				</td>
				<td>
					<p class="station">출발역-중간역-도착역</p>
					<p class="station">출발역-중간역-도착역</p>
					<p class="station">출발역-중간역-도착역</p>
				</td>
				<td align="center">
					<p>10분</p>
					<p>20분</p>
					<p>15분</p>
				</td>
			</tr>
		</table>
	</div>
	<br>
	<br>
	<footer class="w3-center w3-light-grey w3-padding-32">
		<p>
			Powered by <a href="https://www.w3schools.com/w3css/default.asp"
				title="W3.CSS" target="_blank" class="w3-hover-text-green">w3.css</a>
		</p>
	</footer>
</body>
</html>














