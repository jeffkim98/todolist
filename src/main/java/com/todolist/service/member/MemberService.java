package com.todolist.service.member;

import com.todolist.domain.LoginDTO;
import com.todolist.domain.MemberDTO;

public interface MemberService {
	
	// 회원가입 저장
	boolean memberStorage(MemberDTO memberDTO);
	
	// 아이디 중복검사
	boolean idIsDuplicate(String tmpMemberId);

	// 로그인
	MemberDTO login(LoginDTO loginDTO);

	// 회원 탈퇴
	int deleteMember(String memberId, String memberPwd);

	// 비밀번호 변경
	int changePwd(MemberDTO memberDTO);
	
	// 비밀번호 변경시 기존 비밀번호와 검사
	Integer checkPwd(String memberId, String currentPwd);
	


	
}
