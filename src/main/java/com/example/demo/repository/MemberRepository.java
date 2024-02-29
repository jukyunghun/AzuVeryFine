package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.model.Member;

@Repository
public interface MemberRepository extends JpaRepository<Member, Integer>{

	Member findByMbEmailAndMbPw(@Param("mbEmail") String mbEmail, @Param("mbPw") String mbPw);

	Member findByMbEmail(@Param ("mbEmail") String mbEmail);
}
