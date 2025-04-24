<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>로그인</title>
<c:if test="${not empty msg}">
<script type="text/javascript">

$(function () {
	
	$("#memberId").on("blur" , function () {
	
		let id = $("#memberId").val();
		
		if (id == ""){
			outputError("아이디를 입력해주세요!!" , $("#memberId") , "red");
			$("#memberId").focus();
		} else {
			outputError("" , $("#memberId") , "green")
		}
		
	});
	
	$("#memberPwd").on("blur" , function () {
		
		let pwd = $("#memberPwd").val();
		
		if (pwd == ""){
			outputError("비밀번호를 입력해주세요!!" , $("#memberPwd") , "red");
			$("#memberPwd").focus();
		} else {
			outputError("" , $("#memberPwd") , "green")
		}
		
	});
});
alert("${msg}");

function outputError(errorMsg, tagObj, color) {
	let errTag = $(tagObj).prev(); // <span></span>
	$(errTag).html(errorMsg);
	$(errTag).css("color",color);
	$(tagObj).css("border-color",color);
}


</script>
</c:if>
<style type="text/css">
h1{
text-align: center;
}

.button{
text-align: center;
}

</style>
</head>
<body>

	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">

			<h1>로그인</h1>

			<form action="login" method="post">
				<div class="mb-3 mt-3">
					<label for="memberId">아이디 :</label> 
					<span Id="idError"></span>
					<input type="text" class="form-control" id="memberId" placeholder="아이디를 입력하세요!!" name="memberId">
				</div>

				<div class="mb-3">
					<label for="memberPwd">비밀번호 :</label> 
					<span Id="pwdError"></span>
					<input type="password" class="form-control" id="memberPwd" placeholder="비밀번호를 입력하세요!!" name="memberPwd">				
				</div>
				
				<div class = "button">
				<button type="submit" class="btn btn-outline-primary" ">로그인</button>
				<a class="btn btn-outline-danger" href="/">홈페이지로 돌아가기</a>
				</div>
			</form>
			</div>
		</div>
	</div>

	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>