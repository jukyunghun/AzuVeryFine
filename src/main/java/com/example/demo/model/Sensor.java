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
@Table(name="tbSensor") //생성되는 테이블 이름
@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Sensor {

	
	
	public Sensor(Member member, LocalDateTime installedAt, String sensorLoc) {
		super();
		this.member = member;
		this.installedAt = installedAt;
		this.sensorLoc = sensorLoc;
	}

	// 센서 식별자 
	// insert시 값 디폴트값 들어가게 값 넘기면 안됨!
	@Id // primary 키 지정
	@Column(name="sensorIdx")
    private long sensorIdx;

    // 회원 아이디(email) 
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sensorOwner",referencedColumnName = "mbEmail", nullable = false)
    private Member member;

    // 센서 설치일자 
    // insert시 값 디폴트값 들어가게 값 넘기면 안됨!
    @Column(name="installedAt", length=40, nullable = false)
    private LocalDateTime installedAt;

    // 센서 설치위치 
    @Column(name="sensorLoc", length=50, nullable = false)
    private String sensorLoc;
}
