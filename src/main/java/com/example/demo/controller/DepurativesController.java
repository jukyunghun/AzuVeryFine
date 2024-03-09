package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.service.DepurativeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
public class DepurativesController {

	@Autowired
	DepurativeService service;
	
	@PostMapping("depurativeInjection")
	public String depurativeInjection(@RequestParam String amount, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String email = (String)session.getAttribute("email");
		
		if(email == null) {
			email = request.getHeader("userEmail");
		}
		
		service.saveDepurative(email,amount);
		
		return "success"; 
	}
}
