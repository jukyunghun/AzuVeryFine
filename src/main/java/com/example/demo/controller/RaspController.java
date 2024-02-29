package com.example.demo.controller;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.model.Sensor;
import com.example.demo.model.SensorData;
import com.example.demo.service.MemberService;
import com.example.demo.service.SensorDataService;

@Controller
public class RaspController {
	
	@Autowired
	SensorDataService sensorDataService;
	
	Sensor sensor = new Sensor();
	SensorData sensorData;
	
	@GetMapping("/RaspToSpring")
	public int getSensorValue(@RequestParam("phValue") BigDecimal phValue, @RequestParam("turbiddValue") BigDecimal turbiddValue,
							  @RequestParam("flowValue") BigDecimal flowValue, @RequestParam("identifier") long identifier) {
		
		sensorData = new SensorData(phValue, turbiddValue, flowValue, new Sensor(identifier, null, null, null, null, null, null, null));
		
		sensorDataService.insertSensingData(identifier, phValue, phValue, flowValue);
		
		return 1;
	}
	
	@GetMapping("/getGraphData")
	public SensorData getGraphData() {
		return sensorData;
	}
	
}
