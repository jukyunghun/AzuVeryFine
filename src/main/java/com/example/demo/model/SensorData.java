package com.example.demo.model;

import java.math.BigDecimal;
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
@Table(name="tb_sensing") //생성되는 테이블 이름
@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class SensorData {

	// 측정 순번 
	// insert시 값 디폴트값 들어가게 값 넘기면 안됨!
	@Id // primary 키 지정
	@Column(name="sensing_idx")
    private long sensing_idx;

    // 측정 값 
	@Column(name="sensing_value", nullable = false)
    private BigDecimal sensing_value;

    // 측정 날짜 
	// insert시 값 디폴트값 들어가게 값 넘기면 안됨!
	@Column(name="sensing_at", length=40, nullable = false)
    private Date sensing_at;

    // 센서 식별자 
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sensor_idx", referencedColumnName = "sensor_idx", nullable = false)
    private Sensor sensor;
}
