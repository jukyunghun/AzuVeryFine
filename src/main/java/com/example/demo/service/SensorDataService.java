package com.example.demo.service;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
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
    public void insertSensingData(long identifier, BigDecimal phValue, BigDecimal turbidValue, BigDecimal inFlowValue, BigDecimal outFlowValue) {
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
        sensorData.setInFlowValue(inFlowValue);
        sensorData.setOutFlowValue(outFlowValue);
        sensorData.setSensingAt(LocalDateTime.now());

        entityManager.persist(sensorData);
        System.out.println("센서데이터 삽입하는 jpa메서드 들어옴");
    }
	
	public List<Object[]> getSensorDataForLastSixDays(String memberEmail) {
	    List<Object[]> sensorDataList = new ArrayList<>();
	    LocalDateTime now = LocalDateTime.now().withHour(0).withMinute(0).withSecond(0).withNano(0); // 오늘 날짜의 00시 00분 00초
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

	    for (int i = 0; i <= 5; i++) {
	        LocalDateTime startDateTime = now.minusDays(i);
	        LocalDateTime endDateTime = startDateTime.plusDays(1);
	        List<Object[]> data = repository.findByCustomQuery(memberEmail, startDateTime, endDateTime);

	        for (Object[] row : data) {
	            Timestamp timestamp = (Timestamp) row[1]; // java.sql.Timestamp로 캐스팅
	            LocalDateTime dateTime = timestamp.toLocalDateTime(); // LocalDateTime으로 변환
	            
	            String formattedDateTime = dateTime.format(formatter); // 날짜 및 시간을 문자열로 변환
	            
	            // 문자열로 변환된 날짜 및 시간을 포함하는 Object 배열을 생성하여 리스트에 추가
	            Object[] newData = {row[0], formattedDateTime, row[2], row[3], row[4], row[5], row[6], row[7]};
	            sensorDataList.add(newData);
	        }
	    }
	    return sensorDataList;
	}
	
	
	
}
