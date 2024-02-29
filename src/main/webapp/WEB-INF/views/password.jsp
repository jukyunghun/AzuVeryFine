<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Password Reset - SB Admin</title>
<link href="/final/assets/css/styles.css" rel="stylesheet">
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body class="bg-white">
	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-5">
							<div class="card shadow-lg border-0 rounded-lg mt-5">
								<div class="card-header">
									<h3 class="text-center font-weight-light my-4">비밀번호 찾기</h3>
								</div>
								<div class="card-body">
									<div class="small mb-3 text-muted">비밀번호를 찾고자 하는 이메일 주소를
										입력하십시오</div>
									<form action="reset-password.jsp" method="post">
										<div class="form-floating mb-3">
											<input class="form-control" id="inputEmail" name="email"
												type="email" placeholder="name@example.com" /> <label
												for="inputEmail">이메일 주소 입력</label>
										</div>
										<div
											class="d-flex align-items-center justify-content-between mt-4 mb-0">
											<a class="small" href="login">로그인</a>
											<button class="btn btn-primary" type="submit">비밀번호
												수정</button>
										</div>
									</form>
								</div>
								<div class="card-footer text-center py-3">
									<div class="small">
										<a href="register">회원가입</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
		<%@ include file="nav/footer.jsp"%>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
<script>
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
	<script src="/final/assets/js/scripts.js"></script>
</body>
</html>