package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.Member;
import com.example.demo.model.Sensor;
import com.example.demo.model.Valve;
import com.example.demo.repository.ValveRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
public class ValveService {

	@Autowired
	ValveRepository repository;
	
	@PersistenceContext
    private EntityManager entityManager;
	
	public Integer toggleValve(String email) {
		System.out.println("서비스");
		Valve valve = repository.findByvalveStatusAndMemberMbEmail("1", email); // 예시로 밸브 상태가 "1"인 것을 가져오도록 설정
		if (valve == null) {
			valve = repository.findByvalveStatusAndMemberMbEmail("0", email); // "1"인 상태의 밸브가 없다면 "0"인 상태의 밸브를 가져옴
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
		return repository.findBySensorSensorIdx(idx);
	}
	
	public List<String> getValveStatus2(String email) {
		Member member = new Member(email);
		return repository.findByCustomQuery(email);
	}
	
	@Transactional
	public void saveValve(Valve valve, Member member) {
		long sensorIdx = (long) entityManager.createQuery("SELECT s.sensorIdx FROM Sensor s WHERE s.member = :sensorOwner")
	            .setParameter("sensorOwner", member)
	            .getSingleResult();
		Sensor sensor = new Sensor();
		sensor.setSensorIdx(sensorIdx);
		valve.setSensor(sensor);
		repository.save(valve);
	}
	
}
