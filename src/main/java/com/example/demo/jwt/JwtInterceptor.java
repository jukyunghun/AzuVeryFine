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
        // CSS, JS, 이미지 파일은 인터셉트하지 않음
        
    	
    	System.out.println(request.getParameter("token"));
    	
    	String path = request.getRequestURI().substring(request.getContextPath().length());
        if (path.startsWith("/assets/") || path.startsWith("/webjars/")) {
            System.out.println("정적 파일 요청");
            return true;
        }
        
        
        

        // 로그인 페이지는 인터셉트하지 않음
        if (path.equals("/final/loginpage") || path.equals("/loginpage")) {
            System.out.println("로그인 페이지 요청");
            return true;
        }

        // 토큰이 있는지 확인
        String token = tokenProvider.getTokenFromRequest(request);
        System.out.println(token);
        if (token == null || !tokenProvider.validateToken(token)) {
            // 토큰이 없거나 유효하지 않은 경우 로그인 페이지로 리다이렉트
            System.out.println("토큰이 없거나 유효하지 않음");
            response.sendRedirect(request.getContextPath() + "/loginpage");
            return false;
        }

        // 토큰이 유효한 경우, 요청 허용
        System.out.println("토큰이 있음, 요청 허용");
        return true;
    }
}
