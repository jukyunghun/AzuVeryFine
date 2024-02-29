package com.example.demo.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;

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
@Table(name="tbSensing") //생성되는 테이블 이름
@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class SensorData {
	
	public SensorData(BigDecimal phValue, BigDecimal turbidValue, BigDecimal flowValue, Sensor sensor) {
		super();
		this.phValue = phValue;
		this.turbidValue = turbidValue;
		this.flowValue = flowValue;
		this.sensor = sensor;
	}

	// 측정 순번 
	// insert시 값 디폴트값 들어가게 값 넘기면 안됨!
	@Id // primary 키 지정
	@Column(name="sensingIdx")
    private long sensingIdx;

    // 측정 값 
	@Column(name="phValue", nullable = false)
    private BigDecimal phValue;
	
	// 측정 값 
	@Column(name="turbidValue", nullable = false)
	private BigDecimal turbidValue;
	
	// 측정 값 
	@Column(name="flowValue", nullable = false)
	private BigDecimal flowValue;

    // 측정 날짜 
	// insert시 값 디폴트값 들어가게 값 넘기면 안됨!
	@Column(name="sensingAt", length=40, nullable = false)
    private LocalDateTime sensingAt;

    // 센서 식별자 
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sensorIdx", referencedColumnName = "sensorIdx", nullable = false)
    private Sensor sensor;
	
	// 센서 오너 이메일
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "mbEmail", referencedColumnName = "mbEmail", nullable = false)
	private Member member;
	
}
