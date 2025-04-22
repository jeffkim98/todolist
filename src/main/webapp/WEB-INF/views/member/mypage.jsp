<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>마이페이지</title>
<script type="text/javascript">

</script>
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
	    <input type="password" class="form-control" name="currentPwd" id="pwd1">
	  </div>
	  <div class="mb-3">
	    <label class="form-label">새 비밀번호</label>
	    <input type="password" class="form-control" name="newPwd" id="pwd2">
	  </div>
	  <button type="submit" class="btn btn-primary" onclick="return checkPwd();">비밀번호 변경</button>
	</form>

     

      <!-- 수정 버튼 -->
      <div class="text-center ">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal">수정하기</button>
        <a href="${contextPath}/" class="btn btn-secondary">홈으로</a>
        <br />
        <form action="${contextPath }/member/deleteMember" method="post" onsubmit="return confirm('정말로 탈퇴하시겠습니까?');">
        <button type="submit" class="btn btn-danger btn-sm">탈퇴하기</button>
		</form>
		
      </div>

    </div>
  </div>
</div>

<!-- 수정 모달 -->
<div class="modal fade" id="editModal" >
  <div class="modal-dialog">
    <form action="${contextPath}/mypage/update" method="post">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="editModalLabel">회원정보 수정</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label for="memberName" class="form-label">이름</label>
            <input type="text" class="form-control" name="memberName" value="${loginMember.memberName}" required>
          </div>
          <div class="mb-3">
            <label for="email" class="form-label">이메일</label>
            <input type="email" class="form-control" name="email" value="${loginMember.email}" required>
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">저장</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        </div>
      </div>
    </form>
  </div>
</div>

<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>
