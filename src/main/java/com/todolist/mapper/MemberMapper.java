package com.todolist.mapper;

import org.apache.ibatis.annotations.Param;

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
	
	// 회원 탈퇴
	int deleteMember(String memberId);
	
	// 비밀번호 변경
	int changePwd(MemberDTO memberDTO);
	
	// 비밀번호 변경시 기존 비밀번호와 검사
	Integer checkPwd(@Param("memberId")String memberId, @Param("currentPwd")String currentPwd);


}
