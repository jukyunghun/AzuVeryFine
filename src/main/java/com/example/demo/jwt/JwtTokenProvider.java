package com.example.demo.jwt;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;

import java.util.Date;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

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
}