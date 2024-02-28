<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register - SB Admin</title>
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
						<div class="col-lg-7">
							<div class="card shadow-lg border-0 rounded-lg mt-5">
								<div class="card-header">
									<h3 class="text-center font-weight-light my-4">회원가입</h3>
								</div>
								<div class="card-body">
									<form action="login" method="post">
										<div class="row mb-3">
											<div class="col-md-6">
												<div class="form-floating mb-3 mb-md-0">
													<input class="form-control" id="inputFirstName"
														name="firstName" type="text"
														placeholder="Enter your first name" /> <label
														for="inputFirstName">이름</label>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-floating">
													<input class="form-control" id="inputLastName"
														name="lastName" type="text"
														placeholder="Enter your last name" /> <label
														for="inputLastName">성</label>
												</div>
											</div>
										</div>
										<div class="form-floating mb-3">
											<input class="form-control" id="inputEmail" name="email"
												type="email" placeholder="name@example.com" /> <label
												for="inputEmail">이메일 주소 입력</label>
										</div>
										<div class="row mb-3">
											<div class="col-md-6">
												<div class="form-floating mb-3 mb-md-0">
													<input class="form-control" id="inputPassword"
														name="password" type="password"
														placeholder="Create a password" /> <label
														for="inputPassword">비밀번호</label>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-floating mb-3 mb-md-0">
													<input class="form-control" id="inputPasswordConfirm"
														name="confirmPassword" type="password"
														placeholder="Confirm password" /> <label
														for="inputPasswordConfirm">비밀번호 확인</label>
												</div>
											</div>
										</div>
										<div class="mt-4 mb-0">
											<div class="d-grid">
												<button class="btn btn-primary btn-block" type="submit">회원가입</button>
											</div>
										</div>
									</form>
								</div>
								<div class="card-footer text-center py-3">
									<div class="small">
										<a href="login">로그인</a>
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
		axios.interceptors.request.use(config => {
	  const token = '${token}'; // 토큰 값 설정
	  config.headers.Authorization = `Bearer ${token}`;
	  return config;
	});
	<script src="js/scripts.js"></script>
</body>
</html>