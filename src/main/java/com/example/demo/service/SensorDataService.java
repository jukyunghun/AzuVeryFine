package com.example.demo.service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.Member;
import com.example.demo.model.Sensor;
import com.example.demo.model.SensorData;
import com.example.demo.repository.SensorDataRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
public class SensorDataService {
	
	@Autowired
	SensorDataRepository repository;

	@PersistenceContext
    private EntityManager entityManager;
	
	@Transactional
    public void insertSensingData(long identifier, BigDecimal phValue, BigDecimal turbidValue, BigDecimal flowValue) {
        // tbSensor 테이블에서 sensorIdx가 1인 레코드의 sensorOwner 값을 가져옴
		Member member = (Member) entityManager.createQuery("SELECT s.member FROM Sensor s WHERE s.sensorIdx = :sensorIdx")
	            .setParameter("sensorIdx", identifier)
	            .getSingleResult();

        // 가져온 sensorOwner 값을 사용하여 tbSensing 테이블에 데이터 삽입
        SensorData sensorData = new SensorData();
        Sensor sensor = new Sensor(identifier, null, null, null, null, null, null, null);
        sensorData.setSensor(sensor);
        sensorData.setMember(member);
        sensorData.setPhValue(phValue); 
        sensorData.setTurbidValue(turbidValue);
        sensorData.setFlowValue(flowValue);
        sensorData.setSensingAt(LocalDateTime.now());

        entityManager.persist(sensorData);
        System.out.println("센서데이터 삽입하는 jpa메서드 들어옴");
    }
	
	public List<SensorData> getSensorDataForLastSixDays(String memberEmail) {
		System.out.println("서비스 들어옴");
        List<SensorData> sensorDataList = new ArrayList<>();
        LocalDateTime now = LocalDateTime.now().with(LocalTime.MIN); // 오늘 날짜의 00시 00분 00초
        for (int i = 0; i <= 5; i++) {
            LocalDateTime startDateTime = now.minusDays(i);
            LocalDateTime endDateTime = startDateTime.plusDays(1);
            List<SensorData> data = repository.findByMemberMbEmailAndSensingAtBetween(memberEmail, startDateTime, endDateTime);
            sensorDataList.addAll(data);
        }
        return sensorDataList;
    }
	
}
