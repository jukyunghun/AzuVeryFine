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
								<% String error = request.getParameter("error"); %>
								<% if (error != null) { %>
								<div class="alert alert-danger" role="alert">
								<%= error %>
								</div>
								<% } %>
									<form action="1register" method="post">
										<div class="form-floating mb-3">
											<input class="form-control" id="inputEmail" name="email"
												type="email" placeholder="name@example.com" required /> <label
												for="inputEmail">회원 이메일</label>	
										</div>
										<div class="form-floating mb-3">
											<input class="form-control" id="inputPassword"
												name="password" type="password"
												placeholder="Create a password" required /> <label
												for="inputPassword">회원 비밀번호</label>
										</div>
										<div class="form-floating mb-3">
											<input class="form-control" id="inputPasswordConfirm"
												name="confirmPassword" type="password"
												placeholder="Confirm password" required /> <label
												for="inputPasswordConfirm">비밀번호 확인</label> <small
												id="passwordHelpBlock" class="form-text text-danger"></small>
										</div>
										<div class="row mb-3">
											<div class="col-md-6">
												<div class="form-floating mb-3">
													<input class="form-control" id="inputFirstName"
														name="firstName" type="text"
														placeholder="Enter your first name" required /> <label
														for="inputFirstName">회원 이름</label>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-floating">
													<input class="form-control" id="inputPhone" name="phone"
														type="text" placeholder="Enter your phone number"
														pattern="[0-9]+" required /> <label for="inputPhone">회원
														전화</label>
												</div>
											</div>
										</div>
										<div class="form-floating mb-3">
											<input class="form-control" id="inputCompany" name="company"
												type="text" placeholder="Enter your company" required /> <label
												for="inputCompany">회원 소속회사</label>
										</div>
										<div class="row mb-3">
											<div class="col-md-6">
												<div class="form-floating mb-3">
													<input class="form-control" id="inputCompanyAddress"
														name="companyAddress" type="text"
														placeholder="Enter your company address" required /> <label
														for="inputCompanyAddress">회사 주소</label>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-floating mb-3">
													<input class="form-control" id="inputCompanyPhone"
														name="companyPhone" type="text"
														placeholder="Enter your company phone number"
														pattern="[0-9]+" required /> <label
														for="inputCompanyPhone">회사 전화</label>
												</div>
											</div>
										</div>
										<div class="mt-4 mb-0">
											<div class="d-grid">
												<button id="registerBtn" class="btn btn-primary btn-block"
													type="submit" disabled>회원가입</button>
											</div>
										</div>
									</form>
								</div>
								<div class="card-footer text-center py-3">
									<div class="small">
										<a href="loginpage">로그인</a>
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




	<script> src="/final/assets/js/scripts.js"></script>
	<script>
		// 입력값이 변경될 때마다 호출되는 함수
		function checkInputs() {
			var inputs = document.querySelectorAll('input[required]'); // 필수 입력 필드 선택
			var allFilled = true; // 모든 필수 입력 필드가 채워져 있는지 여부
			var password = document.getElementById('inputPassword').value; // 비밀번호 입력값
			var confirmPassword = document
					.getElementById('inputPasswordConfirm').value; // 비밀번호 확인 입력값
			var registerBtn = document.getElementById('registerBtn'); // 회원가입 버튼
			inputs.forEach(function(input) {
				if (!input.value) { // 입력값이 공란일 경우
					allFilled = false;
				}
			});

			if (!allFilled || password !== confirmPassword) { // 모든 필수 입력값이 입력되지 않거나 비밀번호와 비밀번호 확인 값이 일치하지 않는 경우
				registerBtn.disabled = true; // 회원가입 버튼 비활성화
			} else {
				registerBtn.disabled = false; // 회원가입 버튼 활성화
			}
		}

		
		// 입력값 변경 시 checkInputs 함수 호출
		document.querySelectorAll('input').forEach(function(input) {
			input.addEventListener('input', checkInputs);
		});

		// 비밀번호 확인 일치 여부 확인
		document
				.getElementById('inputPasswordConfirm')
				.addEventListener(
						'input',
						function() {
							var password = document
									.getElementById('inputPassword').value;
							var confirmPassword = this.value;
							var passwordHelpBlock = document
									.getElementById('passwordHelpBlock');

							if (password !== confirmPassword) {
								passwordHelpBlock.textContent = '비밀번호가 일치하지 않습니다.';
							} else {
								passwordHelpBlock.textContent = '';
							}
						});
	</script>

	<script>
		// 회원 전화와 회사 전화 필드에 숫자만 입력되도록 함
		document.getElementById('inputPhone').addEventListener('input',
				function() {
					this.value = this.value.replace(/[^0-9]/g, ''); // 숫자가 아닌 문자를 모두 제거
				});

		document.getElementById('inputCompanyPhone').addEventListener('input',
				function() {
					this.value = this.value.replace(/[^0-9]/g, ''); // 숫자가 아닌 문자를 모두 제거
				});
	</script>

	<script>
		// 회원 가입 완료 확인 창
		function showRegistrationConfirmation() {
			alert('회원 가입이 완료되었습니다.');
		}

		// 회원가입 양식 제출 시 확인 창을 표시
		document.getElementById('registrationForm').addEventListener('submit',
				function(event) {
					// 기본 제출 이벤트를 막음
					event.preventDefault();
					// 확인 창을 표시
					showRegistrationConfirmation();
				});
	</script>

	<script src="/final/assets/js/scripts.js"></script>

</body>
</html>