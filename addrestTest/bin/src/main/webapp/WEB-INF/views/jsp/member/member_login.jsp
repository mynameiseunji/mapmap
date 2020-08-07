<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>접속</title>
<!-- <script src="./js/jquery.js"></script> -->
<script src="http://code.jquery.com/jquery-latest.js"></script>

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
 
 /*find password window*/
/*  function pwd_find(){
	 window.open("pwd_find.do","비밀번호 찾기","width=450,height=500");
	 //자바 스크립트에서 window객체의 open("공지창경로와 파일명","공지창이름","공지창속성")
	 //메서드로 새로운 공지창을 만듬.폭이 400,높이가 400인 새로운 공지창을 만듬.단위는 픽셀
 }  */
</script>
</head>
<body>
 <div>
  <h3>접속</h3>
  <form method="post" action="member_login_ok.do" onsubmit="return check()">
   <table>
    <tr>
     <th>전자우편</th>
     <td>
      <input name="email" id="email" size="20" class="input_box" />
     </td>
    </tr>
    
    <tr>
     <th>비밀번호</th>
     <td>
     <input type="password" name="pwd" id="pwd" size="20" class="input_box"/>
     </td>
    </tr>
   </table>
    <div>
    <input type="submit" value="접속" class="input_button" style="width:80px" />
<!--     <input type="reset" value="지우기" class="input_button"
    		onclick="$('#id').focus();" /> -->
    <input type="button" value="회원가입" class="input_button" style="width:80px"
    		onclick="location='member_join.do'" />
<!--     <input type="button" value="비밀번호찾기" class="input_button"
    		onclick="pwd_find()" /> -->
    </div>
  </form>
 </div>
</body>
</html>