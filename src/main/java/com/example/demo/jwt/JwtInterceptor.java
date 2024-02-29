package com.example.demo.jwt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class JwtInterceptor implements HandlerInterceptor {

    @Autowired
    private JwtTokenProvider tokenProvider;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        // 요청에서 토큰 추출
        String token = tokenProvider.getTokenFromRequest(request);

        // 토큰 유효성 검사
        if (token != null && tokenProvider.validateToken(token)) {
            return true; // 유효한 토큰이면 요청 허용
        } else {
            // 유효하지 않은 토큰이거나 토큰이 없는 경우 요청 거부
            response.sendRedirect("/loginpage");
            return false;
        }
    }
}
