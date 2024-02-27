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
@Table(name="tb_sensor") //생성되는 테이블 이름
@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Sensor {

	
	// 센서 식별자 
	// insert시 값 디폴트값 들어가게 값 넘기면 안됨!
	@Id // primary 키 지정
	@Column(name="sensorIdx")
    private long sensorIdx;

    // 회원 아이디(email) 
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sensorOwner",referencedColumnName = "mbEmail", nullable = false)
    private Member member;

    // 센서 UID
    @Column(name="sensorUid", length=30, nullable = false)
    private String sensorUid;

    // 센서 명
    @Column(name="sensorName", length=40, nullable = false)
    private String sensorName;

    // 센서 구분
    @Column(name="sensorType", length=20, nullable = false)
    private String sensorType;

    // 센서 설치일자 
    // insert시 값 디폴트값 들어가게 값 넘기면 안됨!
    @Column(name="installedAt", length=40, nullable = false)
    private String installedAt;

    // 센서 설치위치 
    @Column(name="sensorLoc", length=50, nullable = false)
    private String sensorLoc;

    // 센서 상태
    @Column(name="sensorStatus", length=20, nullable = false)
    private String sensorStatus;
}
