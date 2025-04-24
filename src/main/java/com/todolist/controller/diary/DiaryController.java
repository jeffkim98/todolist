package com.todolist.controller.diary;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.todolist.domain.DiaryDTO;
import com.todolist.domain.DiaryVO;
import com.todolist.domain.MemberDTO;
import com.todolist.domain.SearchDTO;
import com.todolist.mapper.DiaryMapper;
import com.todolist.service.diary.DiaryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/diary")
@Slf4j
@RequiredArgsConstructor
public class DiaryController {

	private final DiaryService diaryService;
	private final DiaryMapper diaryMapper;
	
	@GetMapping("/register")
	public String registerForm(HttpSession session) {
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		
		if (loginMember == null) {
			// 로그인되어 있지 않으면 로그인 페이지
			return "redirect:/member/login";
		}
		
		return "/diary/register";
	}
	
	@PostMapping("/register")
	public String register(DiaryDTO diaryDTO, RedirectAttributes rttr, HttpSession session) {
		
		log.info("diaryDTO : {} ", diaryDTO);
		String resultPage = "redirect:/diary/list";
		
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");	
		
		log.info("loginMember: {} " , loginMember);
		
		
		
		 if (loginMember == null) {
			 // 로그인한 유저가 없으면 로그인 페이지로
		        return "redirect:/member/login";
		    }

		    // 유효성 검사 (비어있으면 다시 등록 페이지로)
		    if (diaryDTO.getTitle().equals("") || diaryDTO.getDueDate().equals("") ) {
		        rttr.addFlashAttribute("status", "fail");
		        return "diary/register"; // 등록 페이지로 다시 이동  
		    } 
		    

		    // 등록 처리
		    DiaryVO diaryVO = DiaryVO.builder()
		            .title(diaryDTO.getTitle())
		            .dueDate(diaryDTO.getDueDate())
		            .writer(loginMember.getMemberId())
		            .finished(diaryDTO.isFinished())
		            .build();

		    try {
		        if (diaryService.register(diaryVO) == 1) {
		            rttr.addFlashAttribute("status", "success");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        log.info("예외 발생!!!");
		        resultPage = "redirect:/diary/register";
		    }

		    return resultPage;
		}
	
	@GetMapping("/list")
	public String viewAll(Model model, HttpSession session) {
		
		MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");
		
		if (loginMember == null) {
			return "redirect:/member/login"; // 로그인하지 않은 경우, 로그인 페이지로 리다이렉트
		} else {
			// 로그인 한 경우
			List<DiaryVO> list = diaryService.viewAll(loginMember.getMemberId());
			
			log.info("list: {} " , list);
			
			model.addAttribute("todolist", list);
			
		}
		
		return "/diary/list"; // 뷰이름 반환
		
	}
	
	// 마감일 수정
	@PostMapping("/updateFinished")
	@ResponseBody
	public String updateFinished(@RequestParam("dno") int dno, 
			@RequestParam("finished") boolean finished) {
		
		log.info("dno : {}", dno);
		log.info("finished : {}", finished);
		
		diaryService.updateFinished(dno, finished);
		
		return "success";
	}
	
	// 글 수정
	@PostMapping("/modify")
	@ResponseBody
	public String modifyDiary(@RequestParam Integer dno,
							@RequestParam String title,
							@RequestParam String dueDateStr) {
		
		log.info("dno : {}",  dno);
		log.info("title : {} ", title);
		log.info("dueDateStr : {}", dueDateStr);
				
		
		// 서비스에 넘길 VO 객체 생성 & 저장
		LocalDate dueDate = LocalDate.parse(dueDateStr);
		
		DiaryVO diaryVO = DiaryVO.builder()
								.dno(dno)
								.title(title)
								.dueDate(dueDate)
								.build();
		
		diaryService.modify(diaryVO);
		
		return "success";
	}
	
	
	// 검색
	@PostMapping("/search")
	public String searchDiary(SearchDTO searchDTO, HttpSession session, Model model) {
		
		log.info("검색해 봅시다!! searchDTO : {} " , searchDTO);
		
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		
		if(loginMember == null) {
			return "/member/login";
		}
		
		searchDTO.setWriter(loginMember.getMemberId());
		
		log.info("searchDTO : {}" , searchDTO);
		
		List<DiaryVO> diaryList = diaryService.searchDiary(searchDTO);
		
		log.info("검색 결과 리스트 : {} " , diaryList);
		
		model.addAttribute("todolist" , diaryList);
		
		return "/diary/list";
	}
	
	// 리스트 삭제
	@PostMapping("/deleteList")
	public String deleteDiary(@RequestParam("dno") int dno) {
		
		log.info("삭제 할 dno : {}",  dno);
		
		diaryMapper.deleteDiary(dno);
	    
	    return "redirect:/diary/list";
	}
	
}
