package com.todolist.service.diary;

import java.util.List;

import org.springframework.stereotype.Service;

import com.todolist.domain.DiaryVO;
import com.todolist.domain.SearchDTO;
import com.todolist.mapper.DiaryMapper;

import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
//@Slf4j
public class DiaryServiceImpl implements DiaryService {

	private final DiaryMapper diaryMapper;
	
	// 글 등록
	@Override
	public int register(DiaryVO diaryVO) {
		return diaryMapper.insert(diaryVO);
	}

	// 전체 목록 조회
	@Override
	public List<DiaryVO> viewAll() {
		
		return diaryMapper.selectAllList();
	}

	// 완료 수정
	@Override
	public void updateFinished(int dno, boolean finished) {
		diaryMapper.updateFinished(dno, finished);
		
	}
	
	// 글 수정
	@Override
	public void modify(DiaryVO diaryVO) {
		diaryMapper.updateDiary(diaryVO);
	}

	// 로그인 한 유저 글 조회
	@Override
	public List<DiaryVO> viewAll(String memberId) {
		
//		log.info(memberId);
//		log.info("allList : {} ",diaryMapper.selectAllListById(memberId));
		
		return diaryMapper.selectAllListById(memberId);
	}

	// 글 찾기
	@Override
	public List<DiaryVO> searchDiary(SearchDTO searchDTO) {
		
		return diaryMapper.selectSearchList(searchDTO);
	}

	// 글 삭제
	@Override
	public List<DiaryVO> deleteList(int dno) {
		
		return diaryMapper.deleteList(dno);
		
		
	}

}
