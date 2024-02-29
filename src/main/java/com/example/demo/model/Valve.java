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
@Table(name="tbValve") //생성되는 테이블 이름
@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Valve {
	
	@Id // primary 키 지정
	@Column(name="valveIdx")
    private long valveIdx;

    // 회원 아이디(email) 
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "valveOwner",referencedColumnName = "mbEmail", nullable = false)
    private Member member;

	// 밸브 UID
    @Column(name="valveUid", length=30, nullable = false)
    private String valveUid;

    // 밸브 명 
    @Column(name="valveName", length=40, nullable = false)
    private String valveName;

    // 밸브 구분 
    @Column(name="valveType", length=20, nullable = false)
    private String valveType;

    // 밸브 설치일자 
    @Column(name="installedAt", length=40, nullable = false)
    private String installedAt;

    // 밸브 설치위치 
    @Column(name="valveLoc", length=40, nullable = false)
    private String valveLoc;

    // 밸브 상태
    @Column(name="valveStatus", length=40, nullable = false)
    private String valveStatus;

    
}
