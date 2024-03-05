package com.example.demo.model;

import java.time.LocalDateTime;

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
	
	
	
	public Valve(Member member, LocalDateTime installedAt, String valveStatus) {
		super();
		this.member = member;
		this.installedAt = installedAt;
		this.valveStatus = valveStatus;
	}

	@Id // primary 키 지정
	@Column(name="valveIdx")
    private long valveIdx;

    // 회원 아이디(email) 
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "valveOwner",referencedColumnName = "mbEmail", nullable = false)
    private Member member;

    // 밸브 설치일자 
    @Column(name="installedAt", length=40, nullable = false)
    private LocalDateTime installedAt;

    // 밸브 상태
    @Column(name="valveStatus", length=40, nullable = false)
    private String valveStatus;
    
    // 센서 식별자 
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sensorIdx", referencedColumnName = "sensorIdx")
    private Sensor sensor;

    
}
