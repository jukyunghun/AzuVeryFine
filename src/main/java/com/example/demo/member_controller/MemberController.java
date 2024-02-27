package com.example.demo.member_controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.example.demo.model.Member;
import com.example.demo.service.MemberService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MemberController {
	
	@Autowired
	MemberService service;
	
	@PostMapping("/login")
	public String login(@RequestParam("email")String email, @RequestParam("pw")String pw) throws JsonMappingException, JsonProcessingException {
		
		Member member = new Member();
		member.setMbEmail(email);
		member.setMbPw(pw);
		
		Member result = service.login(member);
		
		if(result == null) {
			return "fail"; //모바일 앱에서 응답받는 값
		}else {
			//jwt 토큰 받아오는 메서드 호출!
			
			return "";
		}
	}
}
