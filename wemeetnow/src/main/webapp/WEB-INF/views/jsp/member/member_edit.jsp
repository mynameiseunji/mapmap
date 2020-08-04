<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<!-- <script src="/springmember/js/jquery.js"></script> -->
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="<%=request.getContextPath()%>/js/member.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
//Daum address API
function openDaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {				
			document.getElementById('addr1').value = data.address;
		}
	}).open();
}
</script>

</head>
<body>
 <div>
  <h3>회원 정보 수정</h3>
  <form name="f" method="post" action="member_edit_ok.do" onsubmit="return edit_check()">
   <table id="join_t">
    <tr>
     <th>전자우편</th>
     <td>
      <input name="email" id="email" class="input_box" value="${email}" disabled />
     </td>
    </tr>
    
    <tr>
     <th>비밀번호</th>
     <td>
      <input type="password" name="pwd" id="pwd1" class="input_box" />
     </td>
    </tr>
    
    <tr>
     <th>비밀번호확인</th>
     <td>
      <input type="password" name="pwd2" id="pwd2" class="input_box" />
     </td>
    </tr>
    
    <tr>
     <th>별명</th>
     <td>
      <input name="nickname" id="nickname" class="input_box" value="${editm.nickname}" />
     </td>
    </tr>
       
    <tr>
     <th>주소</th>
     <td>
      <input name="addr1" id="addr1" size="40" class="input_box"
      readonly value="${editm.addr1}" onclick="post_search()" />
      <input type="button" value="우편번호검색" class="input_button"
      		onclick="openDaumPostcode()" />
     </td>
    </tr>


   </table>
   
   <div>
    <input type="button" value="이전화면" class="input_button" style="width:80px" 
    onclick="history.go(-1)" />
    <input type="submit" value="정보수정" class="input_button" style="width:80px" />
   </div>
  </form>
 </div>
</body>
</html>
