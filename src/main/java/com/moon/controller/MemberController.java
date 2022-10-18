package com.moon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moon.domain.MemberVO;
import com.moon.service.MemberServiceImpl;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
@Log4j
public class MemberController {
	
	@Setter
	private MemberServiceImpl service;
	
	@Setter(onMethod_= @Autowired)
	private PasswordEncoder pwencoder;

	@RequestMapping("/member.do")
	public void memberView() {
		
	}
	
	@GetMapping("checkUserid.do")
	public @ResponseBody int checkUserid(@RequestParam("userid") String id) {//@ResponseBody json 형식으로 리턴된다
		int result = service.idCheck(id);
		log.info("result: "+result);
		return result;
	}
	
	
	@RequestMapping("/memberinsert.do")
	public String memberinsert(MemberVO member) {
		
		member.setUserpw(pwencoder.encode(member.getUserpw()));
		
		log.info(member+"check!!!!!!!!!!!!!!!!!");
		service.regist(member);
		
		return "redirect:/";
	}
	
	
	@GetMapping("/login.do")
	public void customLogin() {
		
	}
	
	
}