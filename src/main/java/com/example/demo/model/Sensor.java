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
	@Column(name="sensor_idx")
    private long sensor_idx;

    // 회원 아이디(email) 
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sensor_owner",referencedColumnName = "mb_email", nullable = false)
    private Member member;

    // 센서 UID
    @Column(name="sensor_uid", length=30, nullable = false)
    private String sensor_uid;

    // 센서 명
    @Column(name="sensor_name", length=40, nullable = false)
    private String sensor_name;

    // 센서 구분
    @Column(name="sensor_type", length=20, nullable = false)
    private String sensor_type;

    // 센서 설치일자 
    // insert시 값 디폴트값 들어가게 값 넘기면 안됨!
    @Column(name="installed_at", length=40, nullable = false)
    private String installed_at;

    // 센서 설치위치 
    @Column(name="sensor_loc", length=50, nullable = false)
    private String sensor_loc;

    // 센서 상태
    @Column(name="sensor_status", length=20, nullable = false)
    private String sensor_status;
}
