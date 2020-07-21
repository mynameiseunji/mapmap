<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소 넘기기</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function openDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				// 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
				//				document.getElementById('join_zip1').value = data.postcode1;
				//				document.getElementById('join_zip2').value = data.postcode2;
				//				document.getElementById('post').value = data.zonecode;
				document.getElementById('address').value = data.address;
			}
		}).open();
	}
</script>


<!-- 외부 자바스크립트 파일 불러오기 -->
<!-- <script src="member.js"></script>
 -->
</head>
<body>

	<form method="post" action="sendAddr.do">
		<table border=1 width=500 align=center>
			<caption>회원 가입</caption>
			<tr>
				<td>주소</td>
				<td><input type=text size=45 id="address" name="address" placeholder="주소검색을 이용해주세요">
					<input type=button value="주소검색" onClick="openDaumPostcode()"></td>
			</tr>
			<tr>
				<td colspan=2 align=center><input type=submit value="입력">
					<input type=reset value="취소"></td>
			</tr>
		</table>
	</form>
</body>
</html>