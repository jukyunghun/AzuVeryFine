package com.example.demo.model;

import java.time.LocalDateTime;

import org.springframework.data.annotation.CreatedDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity //JPA 관리
@Table(name="tbMember") //생성되는 테이블 이름
@Data
@NoArgsConstructor
public class Member {

	// 회원 이메일
	@Id // primary 키 지정
	@Column(name="mbEmail", length=50)
    private String mbEmail;

    // 회원 비밀번호 
	@Column(name="mbPw", length=30)
    private String mbPw;

    // 회원 이름 
	@Column(name="mbName", length=40)
    private String mbName;

    // 회원 전화 
	@Column(name="mbPhone", length=20)
    private String mbPhone;

    // 회원 소속회사 
	@Column(name="companyName", length=40)
    private String companyName;

    // 회사 주소 
	@Column(name="companyAddr", length=1000)
    private String companyAddr;

    // 회사 전화 
	@Column(name="companyTel", length=20)
    private String companyTel;

//    // 회원 가입일자 
//	// insert시 값 디폴트값 들어가게 값 넘기면 안됨!
//	@Column(name="joinedAt", length=50)
//    private String joinedAt;

    // 회원 구분 
	@Column(name="mbRole", length=20)
    private String mbRole;
	
	 @Column(name = "joinedAt")
	    private LocalDateTime joinedAt;
}
