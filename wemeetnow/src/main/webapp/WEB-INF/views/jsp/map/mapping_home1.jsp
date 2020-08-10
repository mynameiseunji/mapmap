<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<title>title</title>
<!-- <meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!-- <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- <link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
	rel="stylesheet"> -->
<style>
body {
	font-family: 'Nanum Gothic', sans-serif;
}
h1, h2, h3, h4, h5, h6 {
	font-family: 'Nanum Gothic', sans-serif;
	letter-spacing: 5px;
}
</style>
<!-- <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
 -->
 <body>

	<!-- Navbar (sit on top) -->
	//<div class="w3-top w3-light-blue">
		<div class="w3-bar w3-white w3-padding w3-card"
			style="letter-spacing: 4px;">
			<a href="index.jsp" class="w3-bar-item w3-button">Woori Jigum Manna</a>
			<!-- Right-sided navbar links. Hide them on small screens -->
			<div class="w3-right w3-hide-small">
				<a href="loginform.jsp" class="w3-bar-item w3-button">Sign In</a> <a
					href="joinform.jsp" class="w3-bar-item w3-button">Sign Up</a>
			</div>
			<div class="w3-right w3-hide-large w3-hide-medium">
				<a href="login.jsp" class="w3-bar-item w3-button">
				<i class="fa fa-user-circle fa-lg" aria-hidden="true">
				</i></a>
			</div>
		</div>
	//</div>
	
	
	<div class="container-sm " align="center" style="margin-top: 80px">
		<h3>주소주소</h3>

		<!-- Button to Open the Modal -->
		<div class="input-group mb-3">
			<input type="text" id="bt" class="form-control"
				placeholder="input your address">
			<div class="input-group-append">
				<button type="button" class="btn btn-dark" data-toggle="modal"
					data-target="#myModal">Search</button>
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
								<tr>
									<td>대화역 3호선<br>
										<p class=w3-opacity style='font-size: 12px'>경기 고양시 일산서구
											대화동 2502</p></td>
									</td>
								</tr>
								<tr>
									<td>대화역 3호선<br>
										<p class=w3-opacity style='font-size: 12px'>경기 고양시 일산서구
											대화동 2502</p></td>
								</tr>
								<tr>
									<td>대화역 3호선<br>
										<p class=w3-opacity style='font-size: 12px'>경기 고양시 일산서구
											대화동 2502</p></td>
								</tr>
								<tr>
									<td>대화역 3호선<br>
										<p class=w3-opacity style='font-size: 12px'>경기 고양시 일산서구
											대화동 2502</p></td>
								</tr>
								<tr>
									<td>대화역 3호선<br>
										<p class=w3-opacity style='font-size: 12px'>경기 고양시 일산서구
											대화동 2502</p></td>
								</tr>
							</tbody>
						</table>
					</div>


				</div>
			</div>
		</div>
	</div>
	<br>
	<hr>
	<br>
	<div class="container-sm">
		<ul class="w3-ul w3-card-4">
			<li class="w3-bar"><span
				onclick="this.parentElement.style.display='none'"
				class="w3-bar-item w3-button w3-white w3-xlarge w3-right">×</span>
				<div class="w3-bar-item">
					<span class="w3-large">Mike</span><br> <span>Web
						Designer</span>
				</div></li>

			<li class="w3-bar"><span
				onclick="this.parentElement.style.display='none'"
				class="w3-bar-item w3-button w3-white w3-xlarge w3-right">×</span>
				<div class="w3-bar-item">
					<span class="w3-large">Jill</span><br> <span>Support</span>
				</div></li>

			<li class="w3-bar"><span
				onclick="this.parentElement.style.display='none'"
				class="w3-bar-item w3-button w3-white w3-xlarge w3-right">×</span>
				<div class="w3-bar-item">
					<span class="w3-large">Jane</span><br> <span>Accountant</span>
				</div></li>
			<li class="w3-bar" align='center'>
				<button type="submit" class="btn btn-dark" onclick="location.href='center.jsp'">Primary</button>
			</li>
		</ul>
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


