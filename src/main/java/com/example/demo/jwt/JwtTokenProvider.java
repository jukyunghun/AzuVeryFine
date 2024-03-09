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
    // 요청 헤더에서 "Authorization" 헤더 값을 가져와서 Bearer 토큰인지 확인
    String authorizationHeader = request.getHeader("Authorization");
    if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
        String accessTokenHeader = authorizationHeader.substring(7); // "Bearer " 이후의 토큰 값만 추출
        return accessTokenHeader;
    }

    // 요청 쿠키에서 "accessToken" 쿠키 값을 가져옴
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("accessToken".equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
    }

    return null;
}

	public String getRefreshTokenFromRequest(HttpServletRequest request) {
	    System.out.println("들어왔다!");

	    // 요청 헤더에서 "Refresh-Token" 헤더 값을 가져옴
	    String refreshTokenHeader = request.getHeader("Refresh-Token");
	    if (refreshTokenHeader != null) {
	        System.out.println("헤더에서 토큰값 찾음!");
	        return refreshTokenHeader;
	    }

	    // 요청 쿠키에서 "refreshToken" 쿠키 값을 가져옴
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("refreshToken".equals(cookie.getName())) {
	                String refreshTokenCookie = cookie.getValue();
	                System.out.println("쿠키에서 토큰값 찾음!");
	                return refreshTokenCookie;
	            }
	        }
	    }

	    System.out.println("토큰값 못찾음!");
	    return null;
	}
}