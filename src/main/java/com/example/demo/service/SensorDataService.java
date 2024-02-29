package com.example.demo.service;

import java.math.BigDecimal;

import org.springframework.stereotype.Service;

import com.example.demo.model.Member;
import com.example.demo.model.Sensor;
import com.example.demo.model.SensorData;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
public class SensorDataService {

	@PersistenceContext
    private EntityManager entityManager;
	
	@Transactional
    public void insertSensingData(long identifier, BigDecimal phValue, BigDecimal turbidValue, BigDecimal flowValue) {
        // tbSensor 테이블에서 sensorIdx가 1인 레코드의 sensorOwner 값을 가져옴
        String mbEmail = (String) entityManager.createQuery("SELECT s.sensorOwner FROM Sensor s WHERE s.sensorIdx = :sensorIdx")
                .setParameter("sensorIdx", identifier)
                .getSingleResult();

        // 가져온 sensorOwner 값을 사용하여 tbSensing 테이블에 데이터 삽입
        SensorData sensorData = new SensorData();
        Sensor sensor = new Sensor(identifier, null, null, null, null, null, null, null);
        sensorData.setSensor(sensor);
        Member member = new Member(mbEmail, null, null, null, null, null, null, null, null);
        sensorData.setMember(member);
        sensorData.setPhValue(phValue); 
        sensorData.setTurbidValue(turbidValue);
        sensorData.setFlowValue(flowValue);

        entityManager.persist(sensorData);
    }
	
}
