package com.example.demo.service;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.Depurative;
import com.example.demo.model.Member;
import com.example.demo.repository.DepurativeRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
public class DepurativeService {
	
	@Autowired
	DepurativeRepository repository;
	
	@PersistenceContext
    private EntityManager entityManager;

	@Transactional
	public void saveDepurative(String email, String amount) {
		Member member = new Member(email);
		BigDecimal decimal = new BigDecimal(amount);
		Depurative depurative = new Depurative("이상한 약", decimal, LocalDateTime.now(), member);
		repository.save(depurative);
	}
}
