package com.example.demo.model;

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
@Table(name="tb_member") //생성되는 테이블 이름
@Data
@NoArgsConstructor
public class Member {

	// 회원 이메일
	@Id // primary 키 지정
	@Column(name="mb_email", length=50)
    private String mb_email;

    // 회원 비밀번호 
	@Column(name="mb_pw", length=30)
    private String mb_pw;

    // 회원 이름 
	@Column(name="mb_name", length=40)
    private String mb_name;

    // 회원 전화 
	@Column(name="mb_phone", length=20)
    private String mb_phone;

    // 회원 소속회사 
	@Column(name="company_name", length=40)
    private String company_name;

    // 회사 주소 
	@Column(name="company_addr", length=1000)
    private String company_addr;

    // 회사 전화 
	@Column(name="company_tel", length=20)
    private String company_tel;

    // 회원 가입일자 
	// insert시 값 디폴트값 들어가게 값 넘기면 안됨!
	@Column(name="joined_at", length=50)
    private String joined_at;

    // 회원 구분 
	@Column(name="mb_role", length=20)
    private String mb_role;
}
