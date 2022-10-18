package com.moon.excepion;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class CommonExceptionAdvice {
	@ExceptionHandler(Exception.class)
	public String except(Exception ex, Model model) {//모델의 역할: request.setattribute
		
		model.addAttribute("exception", ex);//request.setattribute와 같다, 발생된 예외(ex)가 exception에 저장된다
		return "errPage";//exception이 errPage로 포워딩된다 jsp는 views에 만들기 sample 아님!
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {
		return "custom404";//ex를 custom404.jsp로 포워딩하고 custom404.jsp 실행(jsp는 views 폴더에)
	}
}
