package com.todolist.service.member;

import org.springframework.stereotype.Service;

import com.todolist.domain.LoginDTO;
import com.todolist.domain.MemberDTO;
import com.todolist.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor // 생성자 주입
public class MemberServiceImpl implements MemberService {
	
	private final MemberMapper memberMapper;
	
	// 멤버 저장
	@Override
	public boolean memberStorage(MemberDTO memberDTO) {
		
		boolean result = false;
		
		if (memberMapper.insertMember(memberDTO) == 1) {
			// 가입 성공
			result = true;
		}
		return result;
	}
	
	// 아이디 중복
	@Override
	public boolean idIsDuplicate(String tmpMemberId) {
	
		// 중복 이면 true, 중복아니면 false
		
		boolean result = false;
				
		if (memberMapper.selectMemberId(tmpMemberId) == 1) { // 중복!!!
			result = true;
		}
		return result;
	}

	// 로그인
	@Override
	public MemberDTO login(LoginDTO loginDTO) {
		
		return memberMapper.loginMemberDTO(loginDTO);
	}

	// 회원 탈퇴
	@Override
	public int deleteMember(String memberId) {
		
		return memberMapper.deleteMember(memberId);
	}

	// 비밀번호 변경
	@Override
	public int changePwd(MemberDTO memberDTO) {
		
		return memberMapper.changePwd(memberDTO);
	}

	// 비밀번호 변경시 세션에 저장되어 있는 비밀번호와 확인
	@Override
	public Integer checkPwd(String memberId, String currentPwd) {
		return memberMapper.checkPwd(memberId, currentPwd);
	}
	

	
}
