<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   <!-- JSP 를 위한 설정 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원등록</title>
</head>
<body>
<h3>회원 등록</h3>
<!--                                   현재 위치가 member 폴더 . url 이 /member/save 중에 action url 값은 save -->
<form action="save" method="post">  <!-- url에 입력값 파라미터(? 뒤에 쿼리스트링) 없습니다. -->
	<!-- <input type="text" name = "username" value="테스트용"> -->
	<input type="text" name = "id" placeholder="id 입력하세요."> <br>
	<input type="text" name = "name" placeholder="이름 입력하세요."><br>
	<input type="text" name = "email" placeholder="이메일을 입력하세요."><br>
	<input type="password" name = "password" placeholder="비밀번호를 입력하세요."><br>
	<button>등록</button>  <!-- submit 버튼 -->
</form>
<a href="../">홈</a>
</body>
</html>