package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.Sensor;
import com.example.demo.repository.SensorRepository;

@Service
public class SensorService {

	@Autowired
	SensorRepository repository;
	
	public void saveSensor(Sensor sensor) {
		System.out.println("회원가입시 센서저장");
		repository.save(sensor);
	}
}
