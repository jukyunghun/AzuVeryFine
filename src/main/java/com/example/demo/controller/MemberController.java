package com.example.demo.controller;

import java.time.LocalDateTime;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.example.demo.jwt.JwtTokenProvider;
import com.example.demo.model.Member;
import com.example.demo.model.Sensor;
import com.example.demo.model.Valve;
import com.example.demo.service.MemberService;
import com.example.demo.service.SensorService;
import com.example.demo.service.ValveService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;


import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	
	@Autowired
	MemberService service;
	
	@Autowired
	SensorService sensorService;
	
	@Autowired
	ValveService valveService;
	
	@Autowired
	private JwtTokenProvider jwtTokenProvider;
	
	
	@PostMapping("/login")
	public String login(@RequestParam("email") String email, @RequestParam("password") String pw, Model model, HttpServletResponse response, HttpServletRequest request) throws JsonMappingException, JsonProcessingException {

	    Member member = new Member();
	    member.setMbEmail(email);
	    member.setMbPw(pw);
	    
	    HttpSession session = request.getSession();
	    
	    session.setAttribute("email", email);

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
	            @RequestParam("sensorIoc") String sensorIoc,
	            HttpServletResponse response) {

	      System.out.println("들어옴");
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
	       member.setJoinedAt(LocalDateTime.now());
	       
	       Sensor sensor = new Sensor(member, LocalDateTime.now(), sensorIoc);
	       Valve valve = new Valve(member, LocalDateTime.now(), "0");
	       
	       try {
	           Member result = service.register(member);
	           sensorService.saveSensor(sensor);
	           valveService.saveValve(valve, member);
	           System.out.println(result.getMbEmail());
	           return "redirect:/loginpage"; 
	       } catch (RuntimeException e) {
	           return "redirect:/register?error="+e.getMessage(); 
	       }
	   }
	   
	   @PostMapping("/updateProfile")
	   @ResponseBody
	   public String updateProfile(@RequestParam("fullName") String mbName, @RequestParam("email") String mbEmail, @RequestParam("password") String mbPw, HttpServletRequest request) {
		   HttpSession session = request.getSession();
		   String oldEmail = (String) session.getAttribute("email");
		   
		   Member member = new Member(mbEmail,mbPw,mbName);
		   Integer result = service.updateProfile(member,oldEmail);
		   if(result == null) {
			   return "fail";
		   }else {
			   return "success";
		   }
	   }
	

}


