package com.example.demo.jwt;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;

import java.util.Date;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class JwtTokenProvider {

	@Value("${jwt.secret}") // application.properties에서 시크릿 키를 설정할 수 있습니다.
	private String secret;

	@Value("${jwt.access.expiration}") // application.properties에서 토큰의 유효 기간을 설정할 수 있습니다.
	private long accessExpirationMs;

	@Value("${jwt.refresh.expiration}") // application.properties에서 리프레시 토큰의 유효 기간을 설정할 수 있습니다.
	private long refreshExpirationMs;
	
	public long getAccessExpirationMs() {
        return accessExpirationMs;
    }

//	public String createToken(String username) {
//		long nowMillis = System.currentTimeMillis();
//		long expirationMillis = nowMillis + expirationMs;
//		Date expiration = new Date(expirationMillis);
//
//		return JWT.create().withSubject(username).withExpiresAt(expiration).sign(Algorithm.HMAC256(secret));
//	}
	
	public String createAccessToken(String username) {
        long nowMillis = System.currentTimeMillis();
        long expirationMillis = nowMillis + accessExpirationMs;
        Date expiration = new Date(expirationMillis);
        
        return JWT.create()
                  .withSubject(username)
                  .withExpiresAt(expiration)
                  .sign(Algorithm.HMAC256(secret));
    }

    public String createRefreshToken(String username) {
        long nowMillis = System.currentTimeMillis();
        long expirationMillis = nowMillis + refreshExpirationMs;
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
	public boolean validateAccessToken(String token) {
		try {
			// 토큰을 검증하고 예외가 발생하지 않으면 true 반환
			JWT.require(Algorithm.HMAC256(secret)).build().verify(token);
			return true;
		} catch (JWTVerificationException e) {
			// 토큰 검증 실패 시 false 반환
			return false;
		}
	}
	
	public boolean validateRefreshToken(String refreshToken) {
	    try {
	        JWT.require(Algorithm.HMAC256(secret)).build().verify(refreshToken);
	        return true;
	    } catch (JWTVerificationException e) {
	        return false;
	    }
	}

	public String getAccessTokenFromRequest(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();

		String bearerToken = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("accessToken".equals(cookie.getName())) {
					bearerToken = cookie.getValue();
					break;
				}
			}
		}

		if (bearerToken != null) {
			return bearerToken;
		}
		return null;
	}

	public String getRefreshTokenFromRequest(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();

		String bearerToken = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("refreshToken".equals(cookie.getName())) {
					bearerToken = cookie.getValue();
					break;
				}
			}
		}

		if (bearerToken != null) {
			return bearerToken;
		}
		return null;
	}
}