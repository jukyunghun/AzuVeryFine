package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.Valve;
import com.example.demo.repository.ValveRepository;

@Service
public class ValveService {

	@Autowired
	ValveRepository repository;
	
	public Valve toggleValve() {
		System.out.println("서비스");
		Valve valve = repository.findByvalveStatus("1"); // 예시로 밸브 상태가 "1"인 것을 가져오도록 설정
		if (valve != null) {
			if ("1".equals(valve.getValveStatus())) {
				valve.setValveStatus("0"); // 밸브 상태를 토글하여 업데이트
			} else {
				valve.setValveStatus("1");
			}
			return repository.save(valve); // 변경된 상태를 저장하고 엔티티를 반환
		}
		return null; // 밸브가 없거나 상태가 변경되지 않았을 경우 null 반환
	}

	
	
}
