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
		<script
		axios.interceptors.request.use(config => {
	  const token = '${token}'; // 토큰 값 설정
	  config.headers.Authorization = `Bearer ${token}`;
	  return config;
	});</script>
	<script src="js/scripts.js"></script>
</body>
</html>