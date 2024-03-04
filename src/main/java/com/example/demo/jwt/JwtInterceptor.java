package com.example.demo.jwt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class JwtInterceptor implements HandlerInterceptor {

    @Autowired
    private JwtTokenProvider tokenProvider;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
    	String queryString = request.getQueryString();
        // 쿼리스트링, CSS, JS, 이미지 파일은 인터셉트하지 않음
        String path = request.getRequestURI().substring(request.getContextPath().length());
        if (path.startsWith("/assets/") || path.startsWith("/webjars/") || queryString != null || path.startsWith("/1register/") || path.startsWith("/1register")) {
            return true;
        }

     
        
        // 로그인 페이지는 인터셉트하지 않음
        if (path.equals("/final/loginpage") || path.equals("/loginpage")) {
            System.out.println("로그인 페이지 요청");
            return true;
        }

        // 토큰이 있는지 확인
        String token = tokenProvider.getAccessTokenFromRequest(request);
        System.out.println("AjToken: "+token);
        if (token == null || !tokenProvider.validateAccessToken(token)) {
        	String refreshToken = tokenProvider.getRefreshTokenFromRequest(request);
            if(refreshToken != null && tokenProvider.validateRefreshToken(refreshToken)) {
            	// 리프레시 토큰이 있고 유효한 경우, 새로운 액세스 토큰 발급
                String email = tokenProvider.getUsernameFromToken(refreshToken); // 리프레시 토큰에서 이메일 정보 추출
                String newAccessToken = tokenProvider.createAccessToken(email);
                // 쿠키에 새로운 액세스 토큰 저장
                Cookie newAccessTokenCookie = new Cookie("accessToken", newAccessToken);
                newAccessTokenCookie.setPath("/");
                newAccessTokenCookie.setMaxAge((int) tokenProvider.getAccessExpirationMs() / 1000); // 액세스 토큰 만료 시간을 초 단위로 설정
                response.addCookie(newAccessTokenCookie);
                return true; // 요청 허용
            }else {
            	// 토큰이 없거나 유효하지 않은 경우 로그인 페이지로 리다이렉트
                System.out.println("토큰이 없거나 유효하지 않음");
                response.sendRedirect(request.getContextPath() + "/loginpage");
                return false;
            }
        }

        // 토큰이 유효한 경우, 요청 허용
        System.out.println("토큰이 있음, 요청 허용");
        return true;
    }
}
