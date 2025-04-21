<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>마이페이지</title>
<style type="text/css">
h1 {
text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	
	<div class="container mt-5">
		<div class="row">
		
	<h1>${loginMember.memberName }님의 마이페이지</h1>

	<form action="mypage" method="post"></form>

	

	</div>
	</div>
	
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>