package com.moon.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moon.domain.Criteria;
import com.moon.domain.NoticeVO;
import com.moon.domain.PageVO;
import com.moon.service.NoticeService;

import lombok.Setter;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	
	
	@Setter(onMethod_ = @Autowired)
	private NoticeService service;
	
	
	@GetMapping("/notice.do")
	public void list(Model model, Criteria cri) {//criにはページナンバー,すごい,タイプ,キーワード
		System.out.println("ming");
		model.addAttribute("list", service.getListWithPaging(cri));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageVO(cri, total));
		
	}
	
	
	@GetMapping("/notice_write.do")
	@PreAuthorize("isAuthenticated()")//ログインが成功したユーザーだけが書き込みができる
	public void noticeWrite() {
	}
	
	@PostMapping("/notice_write_pro.do")
	public String noticeList(NoticeVO notice, RedirectAttributes rttr, Principal principal) {//RedirectAttributes : 一回限りのオブジェクトをフォワーディングしてくれる
		String userid = principal.getName();
		notice.setUserid(userid);
		service.register(notice);
		rttr.addFlashAttribute("result", notice.getBno());
		return "redirect:/notice/notice.do";//resultがフォワーディングされるのに一度だけ使える
	}
	

	
	@GetMapping({"/notice_view.do", "/notice_modify.do"})
	   public void read(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) {
	      model.addAttribute("nvo",service.read(bno));
	      model.addAttribute("nextVO", service.nextPage(bno));
	      model.addAttribute("prevVO", service.prevPage(bno));
	   }//要請があれば、渡された値をcriに入れ、criをjspにフォワーディングまで一緒に実行する
	
	
	
	@PostMapping("/notice_modify_pro.do")                 
	public String modify(NoticeVO notice, @ModelAttribute("cri") Criteria cri , RedirectAttributes rttr) {
		if(service.update(notice)) {
			rttr.addFlashAttribute("result", "success");
			
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/notice/notice.do";//自動的にフォワーディングされないから一回限りの属性にpageNumとamountを入れて渡すべき
	}
	
	
	
	
	
	@GetMapping("/notice_delete.do")
	public String delete(@RequestParam("bno") int bno, RedirectAttributes rttr) {
		
		if(service.delete(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/notice/notice.do";
	}
	
	
	
	
	
}//
