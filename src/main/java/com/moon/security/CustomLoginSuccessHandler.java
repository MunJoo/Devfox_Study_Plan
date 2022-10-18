package com.moon.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler { 
                           //로그인 성공했을 때 특정 페이지로 이동시켜주는 인터페이스
                           //=>회원가입한 계정으로 로그인 했을 때 인덱스 페이지로 이동한다거나 관리자 계정으로 로그인 했을 때 adm/adminmanager로 이동

   @Override
   public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
         Authentication auth) throws IOException, ServletException {
      
      List<String> roleNames = new ArrayList<>();
      
      auth.getAuthorities().forEach(authlist -> { //람다식
         roleNames.add(authlist.getAuthority());
      });
      
      if(roleNames.contains("ROLE_ADMIN")) {
         response.sendRedirect("/adm/adminmanager");
         return;
      }
      
      if(roleNames.contains("ROLE_MEMBER")) {
         response.sendRedirect("/adm/adminmanager");
      }
      response.sendRedirect("/");
   }
   

}