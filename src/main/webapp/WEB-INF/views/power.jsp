<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>기기 전원 관리 - SB Admin</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
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
					<h1 class="mt-4" style="font-weight: bold;">기기 전원 관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">기기 전원 관리</li>
					</ol>
					<!-- 기기 전원 제어 -->
					<div class="row">
						<div class="col-lg-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-power-off me-1"></i> 기기 전원 제어
								</div>
								<div class="card-body">
									<div class="form-check form-switch">
										<input class="form-check-input" type="checkbox"
											id="powerSwitch" checked onclick="confirmPower()"> <label
											class="form-check-label" for="powerSwitch">기기 전원
											켜기/끄기</label>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 배관 벨브 제어 -->
					<div class="row">
						<div class="col-lg-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-wrench me-1"></i> 배관 밸브 제어
								</div>
								<div class="card-body">
									<div class="form-check form-switch">
										<input class="form-check-input" type="checkbox"
											id="valveSwitch" onchange="toggleValve()"> <label
											class="form-check-label" for="valveSwitch">배관 밸브
											열기/닫기</label>
									</div>
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
	<script src="js/scripts.js"></script>
	<script>
        function confirmPower() {
            if (confirm("전원을 변경하시겠습니까?")) {
                // 확인을 눌렀을 때의 동작
                // 이 곳에 전원 변경을 처리하는 코드를 추가
            } else {
                // 취소를 눌렀을 때의 동작
                document.getElementById("powerSwitch").checked = !document.getElementById("powerSwitch").checked;
            }
        }

        // 배관 벨브 제어를 위한 JavaScript 함수
        function toggleValve() {
            var valveSwitch = document.getElementById("valveSwitch");
            if (valveSwitch.checked) {
                if (confirm("배관 밸브를 여시겠습니까?")) {
                    // 배관 밸브를 열 때 수행할 작업 추가
                    console.log("배관 밸브가 열렸습니다.");
                } else {
                    // 사용자가 취소한 경우 다시 체크 상태로 변경
                    valveSwitch.checked = false;
                }
            } else {
                if (confirm("배관 밸브를 닫으시겠습니까?")) {
                    // 배관 벨브를 닫을 때 수행할 작업 추가
                    console.log("배관 밸브가 닫혔습니다.");
                } else {
                    // 사용자가 취소한 경우 다시 체크 상태로 변경
                    valveSwitch.checked = true;
                }
            }
        }
    </script>
</body>
</html>