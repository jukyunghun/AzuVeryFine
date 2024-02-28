package com.example.demo.member_controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.jwt.JwtTokenProvider;
import com.example.demo.model.Member;
import com.example.demo.service.MemberService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
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
	@PostMapping("/register")
	public String register(@RequestParam("mbEmail") String mbEmail, 
            @RequestParam("mbPw") String mbPw,
            @RequestParam("mbName") String mbName,
            @RequestParam("mbPhone") String mbPhone,
            @RequestParam("companyName") String companyName,
            @RequestParam("companyAddr") String companyAddr,
            @RequestParam("companyTel") String companyTel,
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
	        return "redirect:/login"; 
	    } else {

	        return "redirect:/register"; 
	    }
	}
}
