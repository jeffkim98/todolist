package com.todolist.mapper;

import com.todolist.domain.LoginDTO;
import com.todolist.domain.MemberDTO;

public interface MemberMapper {

	// 회원 가입
	int insertMember(MemberDTO memberDTO);

	// 아이디 중복검사
	int selectMemberId(String tmpMemberId);

	// 멤버 로그인
	MemberDTO loginMemberDTO(LoginDTO loginDTO);

	// memberId로 이메일 조회
	String selectEmailByMemberId(String memberId);
	
	
}
