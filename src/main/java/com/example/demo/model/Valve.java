package com.example.demo.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity //JPA 관리
@Table(name="tb_valve") //생성되는 테이블 이름
@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Valve {
	
	@Id // primary 키 지정
	@Column(name="valve_idx")
    private long valve_idx;

    // 회원 아이디(email) 
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "valve_owner",referencedColumnName = "mb_email", nullable = false)
    private Member member;

	// 밸브 UID
    @Column(name="valve_uid", length=30, nullable = false)
    private String valve_uid;

    // 밸브 명 
    @Column(name="valve_name", length=40, nullable = false)
    private String valve_name;

    // 밸브 구분 
    @Column(name="valve_type", length=20, nullable = false)
    private String valve_type;

    // 밸브 설치일자 
    @Column(name="installed_at", length=40, nullable = false)
    private String installed_at;

    // 밸브 설치위치 
    @Column(name="valve_loc", length=40, nullable = false)
    private String valve_loc;

    // 밸브 상태
    @Column(name="valve_status", length=40, nullable = false)
    private String valve_status;

    
}
