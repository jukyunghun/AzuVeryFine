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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="nav/navbar.jsp" />
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
									<form id="updateForm" action="/final/updateProfile" method="post">
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
    document.getElementById('updateForm').addEventListener('submit', function(event) {
        event.preventDefault(); // 폼의 기본 동작을 막음

        const passwordInput = document.getElementById('password').value;
        const confirmPasswordInput = document.getElementById('confirmPassword').value;

        // 비밀번호 확인 검사
        if (passwordInput !== confirmPasswordInput) {
            document.getElementById('passwordError').style.display = 'block';
            return; // 비밀번호가 일치하지 않으면 폼 전송을 중지
        }

        // axios를 사용하여 비동기 POST 요청 보냄
        axios.post('/final/updateProfile', new FormData(this))
            .then(function(response) {
                if (response.data === 'success') {
                    // 성공 시 로그인 페이지로 이동
                    alert('회원가입에 성공했습니다. 로그인페이지로 이동합니다');
                    window.location.href = '/final/loginpage';
                } else {
                    // 실패 시 알림 메시지 표시
                    alert('중복된 이메일입니다.');
                }
            })
            .catch(function(error) {
                console.error('오류 발생:', error);
                // 오류 발생 시 알림 메시지 표시
                alert('중복된 이메일입니다.');
            });
    });
        
    </script>
</body>
</html>