package com.example.demo.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity //JPA 관리
@Table(name="tbDepuratives") //생성되는 테이블 이름
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Depurative {

	public Depurative(String depurativeName, BigDecimal input, LocalDateTime inputAt, Member member) {
		super();
		this.depurativeName = depurativeName;
		this.input = input;
		this.inputAt = inputAt;
		this.member = member;
	}

	@Id // primary 키 지정
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="depurativeIdx")
    private long depurativeIdx;
 
	@Column(name="depurativeName", length=50)
    private String depurativeName;

	@Column(name="input")
    private BigDecimal input;
	
	@Column(name="inputAt")
    private LocalDateTime inputAt;
	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "mbEmail",referencedColumnName = "mbEmail", nullable = false)
    private Member member;
}
