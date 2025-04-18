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
}
