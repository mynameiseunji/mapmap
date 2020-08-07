<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정 삭제</title>
<link rel="stylesheet" type="text/css" href="./css/admin.css" />
<link rel="stylesheet" type="text/css" href="./css/member.css" />
<script src="./js/jquery.js"></script>
<script>
 function check(){
	 if($.trim($("#pwd").val())==""){
		 alert("비밀번호 입력");
		 $("#pwd").val("").focus();
		 return false;
	 }
 }
</script>
</head>
<body>
 <div id="del_wrap">
  <h3 class="del_title">계정 삭제</h3>
  <form method="post" action="member_del_ok.lm" onsubmit="return check()">
    <table id="del_t">
     <tr>
      <th>전자우편</th>
      <td>${d_email}</td>
     </tr>
     
     <tr>
      <th>별명</th>
      <td>${d_nname}</td>
     </tr>
     
     <tr>
      <th>비밀번호</th>
      <td>
      <input type="password" name="pwd" id="pwd" size="14" class="input_box" />
      </td>
     </tr>
     
    </table>
    
    <div id="del_menu">
      <input type="button" value="이전화면" class="input_button" style="width:80px" 
    	onclick="history.go(-1)" />
     <input type="submit" value="계정삭제" class="input_button" style="width:80px"/>
    </div>
  </form>
 </div>
</body>
</html>