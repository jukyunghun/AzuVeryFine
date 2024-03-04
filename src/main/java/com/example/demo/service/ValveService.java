package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.Valve;
import com.example.demo.repository.ValveRepository;

@Service
public class ValveService {

	@Autowired
	ValveRepository repository;
	
	public Integer toggleValve(String email) {
		System.out.println("서비스");
		Valve valve = repository.findByvalveStatus("1"); // 예시로 밸브 상태가 "1"인 것을 가져오도록 설정
		if (valve == null) {
			valve = repository.findByvalveStatus("0"); // "1"인 상태의 밸브가 없다면 "0"인 상태의 밸브를 가져옴
		}
		if (valve != null) {
			if ("1".equals(valve.getValveStatus())) {
				valve.setValveStatus("0"); // 밸브 상태를 토글하여 업데이트
			} else {
				valve.setValveStatus("1");
			}
			return repository.updateValveStatusByEmail(valve.getValveStatus(), email); // 변경된 상태를 저장하고 엔티티를 반환
		}
		return null; // 밸브가 없거나 상태가 변경되지 않았을 경우 null 반환
	}

	public Valve getValveStatus(int idx) {
		return repository.findByValveIdx(idx);
	}
	
}
