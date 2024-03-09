package com.example.demo.controller;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.example.demo.model.SensorData;
import com.example.demo.service.SensorDataService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
public class DailyGraphController {
	
	@Autowired
	SensorDataService sensorDataService;
	
	@GetMapping("/getDailyGraphData")
	public List<Object[]> getDailyGraphData(HttpServletRequest request){
		System.out.println("컨트롤러 들어옴");
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		if(email == null) {
			email = request.getHeader("userEmail");
		}
		System.out.println(email);
		return sensorDataService.getSensorDataForLastSixDays(email);
	}
}
