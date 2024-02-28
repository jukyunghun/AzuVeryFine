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
<title>Login - SB Admin</title>
<link href="/final/assets/css/styles.css" rel="stylesheet">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
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
									<h3 class="text-center font-weight-light my-4">로그인</h3>
								</div>
								<div class="card-body">
									<form action="login" method="post">
										<div class="form-floating mb-3">
											<input class="form-control" id="inputEmail" name="email"
												type="email" placeholder="name@example.com" /> <label
												for="inputEmail">이메일 주소</label>
										</div>
										<div class="form-floating mb-3">
											<input class="form-control" id="inputPassword"
												name="password" type="password" placeholder="Password" /> <label
												for="inputPassword">비밀번호</label>
										</div>
										<div class="form-check mb-3">
											<input class="form-check-input" id="inputRememberPassword"
												type="checkbox" value="" /> <label class="form-check-label"
												for="inputRememberPassword">이메일 주소 기억하기</label>
										</div>
										<div
											class="d-flex align-items-center justify-content-between mt-4 mb-0">
											<a class="small" href="password">비밀번호 찾기</a>
											<button class="btn btn-primary" type="submit">로그인</button>
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

		window.onload = function() {
		    const token = getCookie('token');
		    console.log(token);
		    // 토큰을 가져왔다면 이후의 작업을 수행
		   /*  if (token) {
		    	console.log("check");
		        // Axios Interceptors 설정
		        axios.interceptors.request.use(function(config) {
		            config.headers.Authorization = `Bearer ${token}`; // 헤더에 토큰 추가
		            console.log('헤더에 토큰이 추가되었습니다:', config.headers.Authorization); // 헤더에 토큰이 추가되었는지 콘솔에 출력
		            return config;
		        }, function(error) {
		            return Promise.reject(error);
		        });
		        
		        
		    } */
		    $.ajax({
		    	url : "tokenCheck",
		    	data : {"token" : token},
		    	type : "post",
		    	success : function(){
		    		console.log("success");
		    	}, error : function(){
		    		console.log("error");
		    	}
		    });
		
		};
		    
		    
		   
	        
		</script>
	<script type="text/babel" src="/final/assets/js/scripts.js"></script>
</body>
</html>