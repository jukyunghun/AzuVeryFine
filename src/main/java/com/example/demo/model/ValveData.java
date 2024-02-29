package com.example.demo.model;

import java.math.BigDecimal;

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
@Table(name="tbFlowing") //생성되는 테이블 이름
@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ValveData {
	
	// 측정 순번 
	@Id // primary 키 지정
	@Column(name="flowingIdx")
    private long flowingIdx;


    // 측정 값 
	@Column(name="flowingValue", nullable = false)
    private BigDecimal flowingValue;

    // 측정 날짜 
	@Column(name="flowingAt",length=40, nullable = false)
    private String flowingAt;

    // 밸브 식별자 
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "valveIdx", referencedColumnName = "valveIdx", nullable = false)
    private Valve valve;
}
