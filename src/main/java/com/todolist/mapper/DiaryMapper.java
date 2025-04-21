package com.todolist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.todolist.domain.DiaryVO;
import com.todolist.domain.SearchDTO;

public interface DiaryMapper {

	String selectNow();
	
	// 다이어리 등록
	int insert(DiaryVO diaryVO);
	
	// 다이어리 리스트
	List<DiaryVO> selectAllList();

	// 마감일 수정
	void updateFinished(@Param("dno") int dno, @Param("finished") boolean finished);
	
	// 다이어리 수정
	int updateDiary(DiaryVO diaryVO);

	// 로그인한 유저 목록
	List<DiaryVO> selectAllListById(String memberId);
	
	// 내일 마감인 글 조회
	List<DiaryVO> selectDiaryDueTomorrow();
	
	// 검색
	List<DiaryVO> selectSearchList(SearchDTO searchDTO);
	
	// 삭제 
	void deleteDiary(@Param("dno") int dno);
	
	
}
