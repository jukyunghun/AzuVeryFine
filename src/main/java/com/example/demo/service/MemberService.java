package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.example.demo.model.Member;
import com.example.demo.repository.MemberRepository;

import jakarta.transaction.Transactional;

@Service
public class MemberService {

	@Autowired
	MemberRepository repository;
	
	public Member login(Member member) {
		return repository.findByMbEmailAndMbPw(member.getMbEmail(),member.getMbPw());
	}
	
	
	public Member register(Member member) {
        // 이미 존재하는 이메일인지 확인
        Member exist = repository.findByMbEmail(member.getMbEmail());
        if (exist != null) {
        	  throw new RuntimeException("이미 존재하는 이메일입니다."); // 예외 발생
        }
        
        // 존재하지 않는 이메일이면 회원가입 진행
        return repository.save(member);
    }
	
	@Transactional
	public Integer updateProfile(Member member, String oldEmail) {
		return repository.updateMemberByEmail(member.getMbEmail(),member.getMbPw(), member.getMbName(), oldEmail);
	}
}
