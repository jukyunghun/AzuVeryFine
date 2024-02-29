package com.example.demo.member_controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.jwt.JwtTokenProvider;
import com.example.demo.model.Member;
import com.example.demo.service.MemberService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class MemberController {
	
	@Autowired
	MemberService service;
	
	@Autowired
	private JwtTokenProvider jwtTokenProvider;
	
	@PostMapping("/login")
	public String login(@RequestParam("email")String email, @RequestParam("pw")String pw, Model model, HttpServletResponse response) throws JsonMappingException, JsonProcessingException {
		
		Member member = new Member();
		member.setMbEmail(email);
		member.setMbPw(pw);
		
		Member result = service.login(member);
		
		if(result == null) {
			return "login";
		}else {
			// jwt 토큰 받아오는 메서드 호출!
			String token = jwtTokenProvider.createToken(member.getMbEmail());
			// 쿠키에 토큰 저장
		    Cookie cookie = new Cookie("token", token);
		    cookie.setPath("/");
		    cookie.setMaxAge(3600); // 1시간 유효
		    response.addCookie(cookie);
		    // 모델에 담아서 index페이지로 토큰값 넘김!
			model.addAttribute("token", token);
			return "index";
		}
	}
	

	//회원가입
	@PostMapping("/1register")
	public String registerMember(@RequestParam("email") String mbEmail, 
            @RequestParam("password") String mbPw,
            @RequestParam("firstName") String mbName,
            @RequestParam("phone") String mbPhone,
            @RequestParam("company") String companyName,
            @RequestParam("companyAddress") String companyAddr,
            @RequestParam("companyPhone") String companyTel,
            @RequestParam("confirmPassword") String confirmPassword,
            HttpServletResponse response) {

	    if (!mbPw.equals(confirmPassword)) {
	        return "redirect:/register"; 
	    }

	    Member member = new Member();
	    member.setMbEmail(mbEmail);
	    member.setMbPw(mbPw);
	    member.setMbName(mbName);
	    member.setMbPhone(mbPhone);
	    member.setCompanyName(companyName);
	    member.setCompanyAddr(companyAddr);
	    member.setCompanyTel(companyTel);
	    
	    Member result = service.register(member);

	    if (result != null) {
	        return "redirect:/loginpage"; 
	    } else {
	        return "redirect:/register"; 
	    }
	}
	

}


