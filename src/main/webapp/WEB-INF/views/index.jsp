<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈페이지</title>
<style type="text/css">
h1,
h2 {
text-align: center;
}
</style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container mt-5">
		<div class="row">
		
			
			<c:choose>
      <c:when test="${loginMember == null }">
	        <h1>안녕하세요!! <br> TodoList 입니다!!</h1>
	        <br>
	        <h2>TodoList를 이용하시려면 로그인 먼저 해주세요!!</h2>
        </c:when>
        
        <c:otherwise>
       <h1>환영합니다!! <br>${loginMember.memberName }님의 ToDoList 입니다!!</h1>
      		 </c:otherwise>
         </c:choose>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>