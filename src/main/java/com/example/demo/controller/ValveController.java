package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.Valve;
import com.example.demo.service.ValveService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ValveController {
		
	@Autowired
	ValveService service;
	
	@PostMapping("/power")
	public void valveCon(@RequestParam("valveStatus") String valveStatus, HttpServletResponse response, HttpServletRequest request) throws JsonMappingException, JsonProcessingException {
	    if ("1".equals(valveStatus) || "0".equals(valveStatus)) {
	    	System.out.println("컨트롤러");
	    	HttpSession session = request.getSession();
	    	String email = (String)session.getAttribute("email");
	    	Integer valve = service.toggleValve(email); // 밸브 상태 토글
	    	if (valve != null) {
	    		System.out.println("성공");
	    		response.setStatus(HttpServletResponse.SC_OK); // 성공적으로 처리됨
	    	} else {
	    		response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 서버 오류 발생
	    	}
	    } else {
	    	response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 잘못된 요청
	    }
	}
	
	@GetMapping("/valveGetStatus")
	@ResponseBody
	public String getValveStatus(HttpServletRequest request) {
		System.out.println("메서드 들어옴");
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		
		List<String> result = service.getValveStatus2(email);
		String result2 = result.get(0);
		return result2;
	}
}
