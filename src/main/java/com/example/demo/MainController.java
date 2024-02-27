package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

	
	
	@GetMapping("/connect")
	public String connect() {
		return "connect";
	}
	
	@GetMapping("/index")
	public String index() {
		return "index";
	}
	
	@GetMapping("/password")
	public String password() {
		return "password";
	}
	
	@GetMapping("/power")
	public String power() {
		return "power";
	}
	
	@GetMapping("/precise")
	public String precise() {
		return "precise";
	}
	
	@GetMapping("/profile")
	public String profile() {
		return "profile";
	}
	
	@GetMapping("/register")
	public String register() {
		return "register";
	}
	
	@GetMapping("/Test")
	public String Test() {
		return "Test";
	}
	
}
