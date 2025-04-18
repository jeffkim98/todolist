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
	
	@Override
	public boolean memberStorage(MemberDTO memberDTO) {
		// 멤버 저장 메서드
		
		boolean result = false;
		
		if (memberMapper.insertMember(memberDTO) == 1) {
			// 가입 성공
			result = true;
		}
		return result;
	}

	@Override
	public boolean idIsDuplicate(String tmpMemberId) {
		// 아이디 중복 메서드
		// 중복 이면 true, 중복아니면 false
		
		boolean result = false;
				
		if (memberMapper.selectMemberId(tmpMemberId) == 1) { // 중복!!!
			result = true;
		}
		return result;
	}

	@Override
	public MemberDTO login(LoginDTO loginDTO) {
		// 로그인 메서드
		return memberMapper.loginMemberDTO(loginDTO);
	}

}
