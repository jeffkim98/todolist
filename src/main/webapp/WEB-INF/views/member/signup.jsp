<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>회원가입</title>
<script type="text/javascript">

$(function () {
	// 아이디 이벤트
	$("#memberId").on("blur" , function () {
		let tmpMemberId = $("#memberId").val();
		console.log(tmpMemberId);
		// 아이디 : 필수 , 중복 불가, 길이 (6 ~ 12자)
		
		if (tmpMemberId.length < 6 || tmpMemberId.length > 12) {
			outputError("아이디는 6 ~ 12글자 이내로 입력하세요!!" , $("#memberId"), "red");
			$("#memberId").focus();
			
		} else {
			// 아이디 중복 체크
		  $.ajax({
          url: "/member/isDuplicate" , // 데이터가 송수신될 서버의 주소
          type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
		  data:{
			  "tmpMemberId" : tmpMemberId
		  }, // 보내는 데이터
          dataType: "json", // 수신받을 데이터 타입 (MIME TYPE)
          // async: false, // 동기 통신 방식
          success: function (data) {
            // 통신이 성공하면 수행할 함수
            console.log(data);
            if (data.msg == "duplicate"){
            	
            	outputError("중복된 아이디입니다!! 다시 입력해 주세요!!" ,$("#memberId"),"red");
            	$("#memberId").focus();
            	$("#idValid").val("");
            	
            } else if (data.msg == "not duplicate") {
            	outputError("아이디가 중복되지 않습니다!!",$("#memberId"),"green");
            	$("#idValid").val("checked");
           }
			
          },
          error: function () {},
          complete: function () {
          },
        });
			
			
		}
		
	});
	
	
	// 비밀번호 체크 이벤트
	$("#memberPwd1").blur(function () {
		// 비밀번호 4 ~ 8자
	
		let tmpPwd = $("#memberPwd1").val();
		
		if (tmpPwd != $("#memberPwd2")) {
			outputError("비밀번호가 바뀌었습니다!!" , $("#memberPwd2") ,"red");
		} else {
			outputError("입력 완료!!" , $("#memberPwd2") , "green");
		}
		
		if (tmpPwd.length < 4 || tmpPwd.length > 8) {
			outputError("비밀번호는 4 ~ 8자로 입력하세요!!" , $("#memberPwd1") , "red");
			$("#memberPwd1").val("");
			$("#memberPwd1").focus();
		} else {			
			outputError("입력 완료!!" , $("#memberPwd1") , "green");	
		}
	});
	
	// 비밀번호 확인 체크 이벤트
	$("#memberPwd2").blur(function () {
		
		let tmpPwd1 = $("#memberPwd1").val();
		let tmpPwd2 = $("#memberPwd2").val();
		
		if (tmpPwd1.length < 4 || tmpPwd1.length > 8) {
			return;
		}
		
		if (tmpPwd1 != tmpPwd2){
			outputError("비밀번호가 다릅니다!! 다시 입력해주세요!!",$("#memberPwd2"),"red");
			$("#memberPwd2").val("");
			$("#memberPwd2").focus();
			$("#pwdValid").val("");
			
		} else {			
			
			outputError("비밀번호가 일치합니다!!",$("#memberPwd2"),"green");
			$("#pwdValid").val("checked");
			
		}
	});
	
	// 이메일 이벤트
	$("#email").blur(function () {
		if ($("#email").val().length > 0) {
			checkEmail();
		} else {
			outputError("이메일은 필수 입력 항목입니다." , $("#email"), "red");
		}
		
	});
	
	// 이름 이벤트
	$("#memberName").blur(function () {
		
		let tmpName =  $("#memberName").val();
		
		if(tmpName.length < 2) {
			outputError("이름을 입력해 주세요!!" , $("#memberName"),"red");
			$("#memberName").focus();
		} else {
			outputError("" , $("#memberName"), "green");
			$("#nameValid").val("checked");
			
		}
		
	});
	
});

	// 이메일 형식 기능
	function checkEmail() {

		let tmpMemberEmail = $("#email").val();
		let emailRegExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		
		if (!emailRegExp.test(tmpMemberEmail)) {
			outputError("이메일 형식이 아닙니다." , $("#email"), "red");
		} else {
			outputError("이메일 형식입니다." , $("#email"), "green");
			
			callSendMail(); // 이메일 발송
		}
		
	}
	
	// 인증코드를 보내는 기능
	function callSendMail() {
		
		  $.ajax({
	          url: "/member/callSendMail" , // 데이터가 송수신될 서버의 주소
	          type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			  data:{
				  "tmpMemberEmail" : $("#email").val()
			  }, // 보내는 데이터
	          dataType: "text", // 수신받을 데이터 타입 (MIME TYPE) (text, json, xml)
	          // async: false, // 동기 통신 방식
	          success: function (data) {
	            // 통신이 성공하면 수행할 함수
	            console.log(data);
	            if (data == "success") {
	            	alert("이메일로 인증번호를 발송했습니다. 인증코드를 입력해주세요.")
	            	
	            	if ($(".authenticationDiv").length == 0) {
	            		
	            	showAuthenticateDiv(); // 인증번호를 입력받을 태그 요소를 출력
	            	
	            	}
	            	startTimer(); // 타이머 동작
	            	
	            }
				
	          },
	          error: function () {},
	          complete: function () {
	          },
	        });
		}
	
	// 인증코드 입력칸 기능
	function showAuthenticateDiv() {
		
		let authDiv = `
			<div class = "authenticationDiv mt-2">
			<input type="text" class="form-control" id="memberAuthCode" placeholder="인증번호를 입력하세요..." />
			<div class = "d-flex align-items-center">
			<span class = "timer">3:00</span>
			</div>
			<button type="button" id="authBtn" class="btn btn-info" onclick="checkAuthCode();">인증하기</button>
			</div>`;
		
		$(authDiv).insertAfter("#email");
		
	}
	
	// 인증을 하게 되면 완료시켜주는 기능 
	function checkAuthCode() {
		let memberAuthCode = $("#memberAuthCode").val();

		$.ajax({
	        url: "/member/checkAuthCode" , // 데이터가 송수신될 서버의 주소
	        type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			  data:{
				  "memberAuthCode" : memberAuthCode
			  }, // 보내는 데이터
	        dataType: "text", // 수신받을 데이터 타입 (MIME TYPE) (text, json, xml)
	        // async: false, // 동기 통신 방식
	        success: function (data) {
	          // 통신이 성공하면 수행할 함수
	          console.log(data);
	          if(data == "success"){
	        	  outputError("인증완료",$("#email"),"green");
	        	  $(".authenticationDiv").remove();
	        	  $("#emailValid").val("checked");
	          } 

				
	        },
	        error: function () {},
	        complete: function () {
	        },
	      });


	}
	
	// 타이머 기능
	let timeLeft = 120; // 120초(2분)
	let intervalId = null;
	
	function startTimer() {
		
		 clearTimer();	

		 timeLeft = 120; // 시간을 2분으로 초기화
		 updateDisplay(timeLeft);
		 
		 intervalId = setInterval(function() {
			timeLeft--;
			updateDisplay(timeLeft);
			
			 if (timeLeft <= 0) {
				// 타이머 종료
				 clearTimer();
				 expiredTimer();
			 }
		}, 1000);
		 
	}
	
	function expiredTimer() {
		// 인증하기 버튼 비활성화
		$("#authBtn").prop("disabled",true);
		
		// 타이머 종료시 back-end에도 인증시간이 만료되었음을 알려야 한다.
		if ($("#emailValid").val() !== "checked") {
			
			$.ajax({
		          url: "/member/clearAuthCode" , // 데이터가 송수신될 서버의 주소
		          type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
		          dataType: "text", // 수신받을 데이터 타입 (MIME TYPE) (text, json, xml)
		          // async: false, // 동기 통신 방식
		          success: function (data) {
		            // 통신이 성공하면 수행할 함수
		            console.log(data);
		            alert("인증시간이 만료되었습니다. 이메일 주소를 다시 입력하고 재인증 해주세요.");
		            $(".authenticationDiv").remove();
		            $("#email").val("").focus();			
	          },
	          error: function () {},
	          complete: function () {
	          },
		    });
		}
	}

	
	// 시간을 출력
	function updateDisplay(seconds) {
		// 시간 출력 = 2:00
		
		let min = Math.floor(seconds / 60);
		let sec = String(seconds % 60).padStart(2,"0");
		let remainTime = min + ":" + sec;
		$(".timer").html(remainTime);
		
		
	}
	
	function clearTimer() {
		if (intervalId != null){

			clearInterval(intervalId);
			intervalId = null;	
		}
	}


	function idValid() {
		let result = false;
	
		if ($("#idValid").val() == "checked"){
			result = true;
		}
	
		return result;
	}

	function pwdValid() {
		let result = false;
		
		if($("#pwdValid").val()== "checked"){
			result = true;
		
		}	
		return result;
	}

	function emailValid() {
		let result = false;
		
		if($("#emailValid").val()== "checked"){
			result = true;
		
		}	
		return result;
	}

	function nameValid() {
		
		let result = false;
		
		if ($("#nameValid").val()== "checked"){
			result = true;
		} 
		return result;
	}

	function outputError(errorMsg, tagObj, color) {
		let errTag = $(tagObj).prev(); // <span></span>
		$(errTag).html(errorMsg);
		$(errTag).css("color",color);
		$(tagObj).css("border-color",color);
	}
	
	function clearError() {
		$("#nameError").html("");
		$("#idError").html("");
		$("#pwdError").html("");
		$("#emailError").html("");
		
	}
	
	function isValid() {
		
		let result = false;
		
		let idCheck = idValid();
		let pwdCheck = pwdValid();
		let emailCheck = emailValid();
		let nameCheck = nameValid();
		
		console.log(idCheck , pwdCheck , emailCheck , nameCheck);
		
		if(idCheck && pwdCheck && emailCheck && nameCheck ) {
			result = true;
		}
		
		return result;	
	}

</script>
<style type="text/css">
h1,h4,h5{
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
		
			<h1>회원가입</h1>
			<br>
			<h4>🎊환영합니다!!🎊</h4>
			<h5>회원가입을 하시려면 아래 항목들을 입력해주세요!</h5>
			
			<form action="signup" method="post">

				<div class="mb-3">
					<label for="memberName">이름 :</label> <span id="nameError"></span>
					<input type="text" class="form-control" id="memberName" placeholder="이름을 입력하세요!!" name="memberName">
					<input type="hidden" id = "nameValid"/>
				</div>

				<div class="mb-3 mt-3">
					<label for="memberId">아이디 :</label> <span id="idError"></span>
					<input type="text" class="form-control" id="memberId" placeholder="아이디를 입력하세요!!" name="memberId">
					<input type="hidden" id = "idValid"/>
				</div>

				<div class="mb-3">
					<label for="memberPwd1">비밀번호 :</label> <span id="pwdError"></span>
					<input type="password" class="form-control" id="memberPwd1" placeholder="비밀번호를 입력하세요!!" name="memberPwd">
				</div>

				<div class="mb-3">
					<label for="memberPwd2">비밀번호 확인 :</label> <span id="pwdError"></span>
					<input type="password" class="form-control" id="memberPwd2" placeholder="비밀번호를 다시 입력해주세요!!">
					<input type="hidden" id = "pwdValid"/>
				</div>

				<div class="mb-3">
					<label for="email">이메일 :</label><span id="emailError"></span>
					<input type="email" class="form-control" id="email" placeholder="이메일을 입력하세요!!" name="email">
					<input type="hidden" id = "emailValid"/> 
				</div>

				<div class="button">
				<button type="submit" class="btn btn-outline-primary" onclick="return isValid();">가입하기</button>
				<button type="reset"  class="btn btn-outline-danger" onclick="clearError();">입력취소</button>
				</div>
			</form>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>