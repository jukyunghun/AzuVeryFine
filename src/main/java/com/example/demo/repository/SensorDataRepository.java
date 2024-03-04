package com.example.demo.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.model.SensorData;

@Repository
public interface SensorDataRepository extends JpaRepository<SensorData, Integer>{

	List<SensorData> findByMemberMbEmailAndSensingAtBetween(String memberMbEmail, LocalDateTime startDateTime, LocalDateTime endDateTime);

}
