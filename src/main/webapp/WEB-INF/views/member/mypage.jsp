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
	    <input type="password" class="form-control" id="newPwd" name="newPwd" >
	  </div>
	  <button type="submit" class="btn btn-primary" onclick="return checkPwd();">비밀번호 변경</button>
	</form>

      <div class="text-center ">
		  <div class="mb-3">
		  </div>
		  <a href="${contextPath}/" class="btn btn-secondary">홈으로</a>
		  <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
			 탈퇴하기
			</button>
      </div>

    </div>
  </div>
</div>

<!-- 탈퇴하기 모달 -->
<div class="modal" id="deleteModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">탈퇴하기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      	<form action="${contextPath}/member/deleteMember" method="post" >
	  <div class="mb-3">
	    <label class="form-label">비밀번호 확인</label>
	    <input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="deleteMember" >
	  </div>
	   <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" class="btn btn-danger" data-bs-dismiss="modal" >탈퇴</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
	  
	   </form>
     </div>

     

    </div>
  </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>
