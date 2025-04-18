package com.todolist.controller.member;

import java.io.IOException;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.todolist.domain.LoginDTO;
import com.todolist.domain.MemberDTO;
import com.todolist.domain.MyResponse;
import com.todolist.service.member.MemberService;
import com.todolist.util.SendMailService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member") // 이 어노테이션은 /member로 시작하는 요청url을 모두 담당한다.
@Slf4j
@RequiredArgsConstructor //  자동으로 생성자를 주입해주는 어노테이션
public class MemberController {
	
	private final MemberService mService; // 서비스 객체 주입
	
	private final SendMailService sendMailService; // 메일 전송 객체 주입

	// signup 페이지를 불러오는 메서드
	// 회원가입 폼 페이지를 여는 메서드
	@GetMapping("/signup")
	public void registerForm() {
		
	}
	
	// 회원가입 후 저장
		@PostMapping("/signup")
		public String registerMember(MemberDTO memberDTO , RedirectAttributes rttr) {
			
			log.info("memberDTO : {} " , memberDTO + "회원가입!!");
			
			String result = "";
			
			if (mService.memberStorage(memberDTO)) {
				// 가입 완료 후 index.jsp로 가자.
				rttr.addAttribute("status", "success");
				result = "redirect:/";
				
			} else {
				// 가입 실패 -> 다시 회원가입 페이지로
				rttr.addAttribute("status", "fail");
				result = "redirect:/member/signup";
			}
			
			log.info(result);
			return result;
		}
		
		// 아이디 중복 검사
		@PostMapping("/isDuplicate")
		public ResponseEntity<MyResponse> idIsDuplicate(@RequestParam("tmpMemberId") String tmpMemberId) {
			
			log.info("tmpMemberId : {}", tmpMemberId + "가 중복되는지 확인하자");
			MyResponse myResponse = null;
			ResponseEntity<MyResponse> result = null;
			
			if (mService.idIsDuplicate(tmpMemberId)) { 
				// 아이디가 중복됨
				myResponse = new MyResponse(200, tmpMemberId, "duplicate");
				
			} else { 
				// 아이디가 중복되지 않음 
				myResponse = MyResponse.builder()
						.code(200)
						.data(tmpMemberId)
						.msg("not duplicate")
						.build();
			}
			log.info("myResponse : {} " , myResponse);
			
			result = new ResponseEntity<MyResponse>(myResponse, HttpStatus.OK);
			
			return result; 
		}
		
		// 인증코드 이메일로 보내기
		@PostMapping("/callSendMail")
		public ResponseEntity<String> sendMailAuthCode(@RequestParam String tmpMemberEmail, HttpSession session) {

			log.info("tmpMemberEmail : {} ", tmpMemberEmail);

			String result = "";

			String authCode = UUID.randomUUID().toString(); // Universally Unique Identifier
			log.info("authCode : {} ", authCode);

			
				try {
					sendMailService.sendMail(tmpMemberEmail, authCode); // 메일 전송
					
					session.setAttribute("authCode", authCode); // 인증코드를 세션객체에 저장
					result = "success";
					
				} catch (MessagingException | IOException e) {
					e.printStackTrace();
					result = "fail";
				}
			
			return new ResponseEntity<String>(result, HttpStatus.OK);

		}
		
		// 인증코드 확인
		@PostMapping("/checkAuthCode")
		public ResponseEntity<String> checkAuthCode(@RequestParam String memberAuthCode, HttpSession session) {
			
			// 유저가 보낸 AuthCode와 우리가 보낸 AuthCode가 일치하는지 확인
			log.info("memberAuthCode : {}", memberAuthCode);
			log.info("session에 저장된 코드 : {} " , session.getAttribute("authCode"));
			
			String result = "fail";
			
			if (session.getAttribute("authCode") != null) {
				String sesAuthCode = (String) session.getAttribute("authCode");
				
				if (memberAuthCode.equals(sesAuthCode)) {
					result = "success";
				}
			}
			
			return new ResponseEntity<String>(result, HttpStatus.OK);
		}
		
		// 인증코드 삭제
		@PostMapping("/clearAuthCode")
		public ResponseEntity<String> clearCode(HttpSession session) {
			
			if (session.getAttribute("authCode") != null) {
				// 세션에 저장된 인증 코드를 삭제
				session.removeAttribute("authCode");
			}

			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		
		@GetMapping("/login")
		public String loginForm() {
			
			return "/member/login";
		}
		
		@PostMapping("/login")
		public String loginPOST(LoginDTO loginDTO, HttpSession session) {
			log.info("loginDTO {} ", loginDTO);
			String resultPage = "";
			
			MemberDTO loginMember = mService.login(loginDTO);
			log.info("loginMember : {}", loginMember );
			
			if (loginMember != null) {
				// 로그인 성공 - > homepage로 보낸다 ("/")
				session.setAttribute("loginMember", loginMember); // 세션에 로그인한 멤버의 정보를 저장
				resultPage = "redirect:/";
			} else {
				// 로그인 실패 -> 로그인 페이지 ("/member/login")
				resultPage = "redirect:/member/login";
			}
			
			return resultPage;
		}
		
		@GetMapping("/logout")
		public String logout(HttpSession session) {
		
			if (session.getAttribute("loginMember") != null) {
				// 세션에 저장된 값들 삭제
				session.removeAttribute("loginMember");
				
				// 세션 무효화
				session.invalidate();
			}
			
			return "redirect:/"; 
		}
		
	
}
