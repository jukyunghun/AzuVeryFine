package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.model.Member;
import com.example.demo.model.SensorData;

@Repository
public interface SensorDataRepository extends JpaRepository<SensorData, Integer>{
	
}
