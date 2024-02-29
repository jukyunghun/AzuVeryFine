package com.example.demo.jwt;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;

import jakarta.servlet.http.HttpServletRequest;

import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Component
public class JwtTokenProvider {

    @Value("${jwt.secret}") // application.properties에서 시크릿 키를 설정할 수 있습니다.
    private String secret;

    @Value("${jwt.expiration}") // application.properties에서 토큰의 유효 기간을 설정할 수 있습니다.
    private long expirationMs;

    public String createToken(String username) {
        long nowMillis = System.currentTimeMillis();
        long expirationMillis = nowMillis + expirationMs;
        Date expiration = new Date(expirationMillis);
        
        return JWT.create()
                  .withSubject(username)
                  .withExpiresAt(expiration)
                  .sign(Algorithm.HMAC256(secret));
    }

    public String getUsernameFromToken(String token) {
        return JWT.require(Algorithm.HMAC256(secret))
                  .build()
                  .verify(token)
                  .getSubject();
    }
    
    // 토큰 유효성 검사 메서드 수정
    public boolean validateToken(String token) {
        try {
            // 토큰을 검증하고 예외가 발생하지 않으면 true 반환
            JWT.require(Algorithm.HMAC256(secret)).build().verify(token);
            return true;
        } catch (JWTVerificationException e) {
            // 토큰 검증 실패 시 false 반환
            return false;
        }
    }

    // HttpServletRequest에서 토큰을 추출하는 메서드 수정
    public String getTokenFromRequest(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        return null;
    }
}