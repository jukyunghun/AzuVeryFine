package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.model.Member;

@Repository
public interface MemberRepository extends JpaRepository<Member, Integer>{

	Member findByMbEmailAndMbPw(@Param("mbEmail") String mbEmail, @Param("mbPw") String mbPw);

	Member findByMbEmail(@Param ("mbEmail") String mbEmail);
	
	@Modifying
    @Query(value = "update tbMember set mbEmail = :newEmail, mbPw = :newPw, mbName = :newName where mbEmail = :oldEmail", nativeQuery = true)
    Integer updateMemberByEmail(@Param("newEmail") String newEmail, @Param("newPw") String newPw, @Param("newName") String newName, @Param("oldEmail") String oldEmail);
}
