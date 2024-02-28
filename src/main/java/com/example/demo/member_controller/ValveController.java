package com.example.demo.member_controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.model.Valve;
import com.example.demo.service.ValveService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ValveController {
		
	@Autowired
	ValveService service;
	
	@PostMapping("/power")
	public void valveCon(@RequestParam("valveStatus") String valveStatus, HttpServletResponse response) throws JsonMappingException, JsonProcessingException {
	    if ("1".equals(valveStatus) || "0".equals(valveStatus)) {
	    	Valve valve = service.toggleValveStatus(); // 밸브 상태 토글
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
}
