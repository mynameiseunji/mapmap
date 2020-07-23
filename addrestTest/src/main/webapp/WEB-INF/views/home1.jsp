<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9c1a242a443c7edc13a52efacd107b25&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>

<script>
	var places = new kakao.maps.services.Places();

	var callback = function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			console.log(result);
			$(".modal-body").empty();
			for ( var i in result) {
				var str = "<p onclick='down(this)'>"
						+ result[i].place_name
						+ "<input type='hidden' name='x' value='" + result[i].x +"'/><input type='hidden' name='addr_name' value='" 
						+ result[i].address_name +"'/><input type='hidden' name='y' value='" + result[i].y +"'/></p>";
				$(".modal-body").append(str);
			}
		}
	};
	$(document).ready(function() {
		$('.btn-primary').click(function() {
			var keyword = $("#bt").val();
			places.keywordSearch(keyword, callback);
		});
	});
	var cnt = 1;
	function down(item) {
		if ($('div.list input[name="x"]').length == 10) {
			alert("최대10개");
		} else {
			var d = "<div class='sel' id='sel"+cnt+"'>" + item.innerHTML + "<input type='button' onclick='remove_addr("+cnt+")' value='x'></div>";
			$('form div.list').append(d);
			$('button.close').click();
			cnt++;
		}
	}
	
	function remove_addr(num){
		var sel="div#sel"+num;
		$(sel).empty();
	}

	// 	places.keywordSearch('판교 치킨', callback);
</script>
</head>
<body>

	<div class="container">
		<h2>Modal Example</h2>
		<!-- Button to Open the Modal -->
		<input type="text" id="bt">
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#myModal">Open modal</button>

		<!-- The Modal -->
		<div class="modal" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">주소 검색</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body"></div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>

				</div>
			</div>
		</div>

	</div>
	<div class="container">
		<form method='post' action="sendAddr.do">
			<div class="list"></div>
			<input type='submit' value='전송'>
		</form>
	</div>
</body>
</html>


