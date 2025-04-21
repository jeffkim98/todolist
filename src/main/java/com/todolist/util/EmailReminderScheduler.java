package com.todolist.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.todolist.domain.DiaryVO;
import com.todolist.mapper.DiaryMapper;
import com.todolist.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component
@RequiredArgsConstructor
@Slf4j
public class EmailReminderScheduler {

	private final DiaryMapper diaryMapper;
	private final SendMailService sendMailService;
	private final MemberMapper memberMapper;

	@Scheduled(cron = "00 59 23 * * *") // 매일밤 11시 59분에 동작
	public void reminderShedule() throws AddressException, FileNotFoundException, MessagingException, IOException {
		// 내일 마감인 글 조회
		List<DiaryVO> list = diaryMapper.selectDiaryDueTomorrow();
		log.info("list : {} ", list);

		// key : writer
		// value: 내일 마감인 글 list
		Map<String, List<DiaryVO>> memberDiaryMap = new HashMap<>();

		for (DiaryVO vo : list) {

			if (!memberDiaryMap.containsKey(vo.getWriter())) {
				memberDiaryMap.put(vo.getWriter(), new ArrayList<DiaryVO>());
			}

			memberDiaryMap.get(vo.getWriter()).add(vo);
		}

		for (Map.Entry<String, List<DiaryVO>> entry : memberDiaryMap.entrySet()) {
			String memberId = entry.getKey();
			log.info("writer : {} ", memberId);
			log.info("list : {} ", entry.getValue());

			String email = memberMapper.selectEmailByMemberId(memberId);
			log.info("email : {}", email);

			// 메일 본문
			StringBuilder sb = new StringBuilder();

			sb.append("<h1>안녕하세요!!</h1>");
			sb.append("<h2>TodoList입니다!!</h2>");
			sb.append("<h3>해야 할 리스트가 내일까지 입니다!!</h3>");

			for (DiaryVO vo : entry.getValue()) {
				sb.append("<br>");
				sb.append("<ul><li>" + vo.getTitle() + "</li></ul>");
			}

			sb.append("<br>" + memberId + "님!! 해야 할 일들을 완료 해주세요!!");
			log.info("내용 :  {} ", sb.toString());
			
			sendMailService.sendReminder(email, sb.toString());
		}

	}

}
