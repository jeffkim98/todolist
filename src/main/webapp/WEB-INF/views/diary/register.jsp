<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>다이어리 등록</title>
<script type="text/javascript">
	$(function () {
	
		$("#title").on("blur",function(){
			validTitle();
		});
		
		$("#dueDate").on("blur",function(){
			validDueDate();
		});
		
	});
	
	
	function validTitle() {
		let result = false;
		// 필수, +++++++100자이상 넘어가면 안된다.+++++++
		let title = $("#title").val();
		
		if (title == ''){
			$("#titleError").html("제목을 입력하세요!!");
			
		} else {
			$("#titleError").html("");
			result = true;
			
		}
		return result;
	}

	function validDueDate() {
		// 마감일 : 입력 당일(오늘)이나 그 이전 날짜는 입력받지 않도록 한다.
		// 필수
		let result = false;
	
		let dueDate = $("#dueDate").val(); // 2025-04-11
		console.log(dueDate == "");
		
		let today = new Date().toISOString().split("T")[0];
// 		console.log(today); // 오늘의 날짜(시간은 빼고)
		
		if (dueDate == "") {
			$("#dueDateError").html("완료일은 필수로 선택해야 합니다!!");
		} else if ((new Date(dueDate) - Date.now()) < 0) {
			
			$("#dueDateError").html("완료일은 오늘 이후로 선택해야 합니다!!");
		} else {
			result = true;
		}
		
		return result;
		
	}
	
	
	function isValid() {
		
		let result = false;
		
		let titleValid = validTitle();
		let dueDateValid = validDueDate();
		
		console.log(titleValid, dueDateValid);
		
		if(titleValid && dueDateValid){
			result = true;
		}
		return result;
	}
	
	function clearErrors() {
		$("#titleError").html("");
		$("#dueDateError").html("");
	}
	
</script>
<style type="text/css">

h1 {
 text-align: center;
}

span {
 color: red;
}


</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
		<div class="container mt-5">
  			<div class="row justify-content-center">
    	<div class="col-md-6">

			<h1>${loginMember.memberName}님의 todolist 등록</h1>

			<form action="/diary/register" method="post">
			
				<div class="mb-3 mt-3">
					<label for="title" class="form-label">제목 :</label>
					<span id="titleError"></span>
					<input type="text" class="form-control" id="title" placeholder="제목" name="title">
				</div>
				
				<div class="mb-3">
					<label for="dueDate" class="form-label">마감일 :</label> 
					<span id="dueDateError"></span>
					<input type="date" class="form-control" id="dueDate" name="dueDateStr">
				</div>
				
				<div>
				<button type="submit" class="btn btn-primary" onclick="return isValid();">등록</button>
				<button type="reset" class="btn btn-secondary" onclick="clearErrors();">취소</button>
				</div>
			</form>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>