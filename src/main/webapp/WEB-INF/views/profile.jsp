<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 정보 수정 - SB Admin</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet">
<link href="/final/assets/css/styles.css" rel="stylesheet">
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body class="sb-nav-fixed">
	<%@ include file="nav/navbar.jsp"%>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<%@ include file="nav/sidebar.jsp"%>
		</div>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4" style="font-weight: bold;">회원 정보 수정</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">회원 정보 수정</li>
					</ol>
					<div class="row">
						<div class="col-lg-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-user-edit me-1"></i> 회원 정보 수정 양식
								</div>
								<div class="card-body">
									<form id="updateForm" action="updateProfile.jsp" method="post">
										<div class="mb-3">
											<label for="fullName" class="form-label">전체 이름</label> <input
												type="text" class="form-control" id="fullName"
												name="fullName" placeholder="전체 이름을 입력하세요" required>
										</div>
										<div class="mb-3">
											<label for="email" class="form-label">이메일 주소</label> <input
												type="email" class="form-control" id="email" name="email"
												placeholder="이메일 주소를 입력하세요" required>
										</div>
										<div class="mb-3">
											<label for="password" class="form-label">새 비밀번호</label> <input
												type="password" class="form-control" id="password"
												name="password" placeholder="새 비밀번호를 입력하세요" required>
										</div>
										<div class="mb-3">
											<label for="confirmPassword" class="form-label">비밀번호
												확인</label> <input type="password" class="form-control"
												id="confirmPassword" placeholder="비밀번호를 다시 입력하세요" required>
											<div id="passwordError" class="form-text"
												style="color: red; display: none;">비밀번호가 일치하지 않습니다.</div>
										</div>
										<button type="submit" class="btn btn-primary">저장</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
			<%@ include file="nav/footer.jsp"%>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/final/assets/js/scripts.js"></script>
	<script>
        const form = document.getElementById('updateForm');
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const passwordError = document.getElementById('passwordError');

        form.addEventListener('submit', function(event) {
            if (passwordInput.value !== confirmPasswordInput.value) {
                event.preventDefault();
                passwordError.style.display = 'block';
            }
        });
        function getCookie(name) {
            const cookieStr = document.cookie;
            const cookies = cookieStr.split(';');
            for (let i = 0; i < cookies.length; i++) {
                const cookiePair = cookies[i].split('=');
                const cookieName = cookiePair[0].trim();
                if (cookieName === name) {
                    return decodeURIComponent(cookiePair[1]);
                }
            }
            return null;
        }

        const token = getCookie('token');
        axios.interceptors.request.use(async config => {
            const token = await getCookie('token'); // 쿠키에서 토큰을 가져옴
            if (token) {
                config.headers.Authorization = `Bearer ${token}`; // 토큰이 있으면 헤더에 추가
            } else {
                // 토큰이 없으면 요청 중단하고 로그인 페이지로 이동
                window.location.href = '/final/loginpage';
                throw new Error('인증 토큰이 없습니다.'); // 요청 중단
            }
            return config;
        }, error => {
            return Promise.reject(error);
        });

        document.addEventListener("DOMContentLoaded", function(){
        	console.log("ㅅㅂ")
        	console.log(token)
        });
        
        
    </script>
</body>
</html>