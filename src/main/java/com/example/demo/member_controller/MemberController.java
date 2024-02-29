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
import org.springframework.web.bind.annotation.ResponseBody;
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
	public String login(@RequestParam("email") String email, @RequestParam("password") String pw, Model model, HttpServletResponse response) throws JsonMappingException, JsonProcessingException {

	    Member member = new Member();
	    member.setMbEmail(email);
	    member.setMbPw(pw);

	    Member result = service.login(member);

	    if (result == null) {
	        return "redirect:login";
	    } else {

	        // 액세스 토큰과 리프레시 토큰 생성
	        String accessToken = jwtTokenProvider.createAccessToken(member.getMbEmail());
	        String refreshToken = jwtTokenProvider.createRefreshToken(member.getMbEmail());

	        // 쿠키에 토큰 저장
	        Cookie accessTokenCookie = new Cookie("accessToken", accessToken);
	        accessTokenCookie.setPath("/");
	        accessTokenCookie.setMaxAge(3600); // 1시간 유효
	        response.addCookie(accessTokenCookie);

	        Cookie refreshTokenCookie = new Cookie("refreshToken", refreshToken);
	        refreshTokenCookie.setPath("/");
	        refreshTokenCookie.setMaxAge(86400); // 1일 유효
	        response.addCookie(refreshTokenCookie);

	        return "redirect:index";
	    }
	}

}
