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

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MemberController {
	
	@Autowired
	MemberService service;
	
	@Autowired
	private JwtTokenProvider jwtTokenProvider;
	
	@PostMapping("/login")
	public String login(@RequestParam("email")String email, @RequestParam("pw")String pw, Model model) throws JsonMappingException, JsonProcessingException {
		
		Member member = new Member();
		member.setMbEmail(email);
		member.setMbPw(pw);
		
		Member result = service.login(member);
		
		if(result == null) {
			return "login";
		}else {
			//jwt 토큰 받아오는 메서드 호출!
			String token = jwtTokenProvider.createToken(member.getMbEmail());
			model.addAttribute("token", token);
			return "index";
		}
	}

	//회원가입
//	@PostMapping("/")
//	public String join(@RequestParam("mbEmail") String mbEmail, @RequestParam("mbPw") String mbPw,
//			@RequestParam("mbName") String mbName, @RequestParam("mbPhone") String mbPhone,
//			@RequestParam("companyName") String companyName,@RequestParam("companyAddr") String companyAddr,@RequestParam("companyTel") String companyTel, HttpServletRequest request) {
//	}
}
