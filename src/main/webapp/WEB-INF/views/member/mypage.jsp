<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>마이페이지</title>
<c:if test="${not empty msg}"> 
<script type="text/javascript">
alert("${msg}");
</script>
</c:if>
<style>
h1 { 
text-align: center; 
}
</style>
</head>
<body>

<jsp:include page="../header.jsp"></jsp:include>

<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">

      <h1>${loginMember.memberName}님의 마이페이지</h1>

      <div class="mb-3">
        <label class="form-label">이름</label>
        <div class="form-control">${loginMember.memberName}</div>
      </div>

      <div class="mb-3">
        <label class="form-label">아이디</label>
        <div class="form-control">${loginMember.memberId}</div>
      </div>
      
       <div class="mb-3">
        <label class="form-label">이메일</label>
        <div class="form-control">${loginMember.email}</div>
      </div>

      <form action="${contextPath}/member/changePwd" method="post" >
	  <div class="mb-3">
	    <label class="form-label">현재 비밀번호</label>
	    <input type="password" class="form-control" name="currentPwd" >
	  </div>
	  <div class="mb-3">
	    <label class="form-label">새 비밀번호</label>
	    <input type="password" class="form-control" name="newPwd" >
	  </div>
	  <button type="submit" class="btn btn-primary" onclick="return checkPwd();">비밀번호 변경</button>
	</form>

      <div class="text-center ">
        <form action="${contextPath }/member/deleteMember" method="post" onsubmit="return confirm('정말로 탈퇴하시겠습니까?');">
         <a href="${contextPath}/" class="btn btn-secondary">홈으로</a>
        <button type="submit" class="btn btn-danger">탈퇴하기</button>
		</form>
		
      </div>

    </div>
  </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>
