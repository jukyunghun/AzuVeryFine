<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>연동 디바이스 관리 - SB Admin</title>
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
					<h1 class="mt-4" style="font-weight: bold;">연동 디바이스 관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">연동 디바이스 관리</li>
					</ol>
					<div class="row">
						<div class="col-xl-12">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-cogs me-1"></i> 연동된 디바이스 목록
								</div>
								<div class="card-body">
									<table class="table table-bordered" id="dataTable" width="100%"
										cellspacing="0">
										<thead>
											<tr>
												<th>디바이스 이름</th>
												<th>연결 시간</th>
												<th>상태</th>
												<th>동작</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>디바이스 1</td>
												<td>2024-02-15 09:30</td>
												<td>활성</td>
												<td><button class="btn btn-danger"
														onclick="toggleConnection(this)">연결 해제</button></td>
											</tr>
											<tr>
												<td>디바이스 2</td>
												<td>2024-02-15 10:15</td>
												<td>활성</td>
												<td><button class="btn btn-danger"
														onclick="toggleConnection(this)">연결 해제</button></td>
											</tr>
											<tr>
												<td>디바이스 3</td>
												<td>2024-02-15 11:00</td>
												<td>비활성</td>
												<td><button class="btn btn-success"
														onclick="toggleConnection(this)">연결</button></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Your Website 2023</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
								&amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/final/assets/js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="/final/assets/demos/chart-area-demo.js"></script>
	<script src="/final/assets/demos/chart-bar-demo.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="/final/assets/demos/datatables-simple-demo.js"></script>

	<script>
function toggleConnection(button) {
    if (button.innerText === '연결 해제') {
        if (confirm('해당 디바이스와의 연결을 해제하시겠습니까?')) {
            button.innerText = '연결';
            button.classList.remove('btn-danger');
            button.classList.add('btn-success');
            // 연결 해제 작업 수행
            // 이 곳에 연결 해제 동작에 관련된 코드를 추가
            updateConnectionStatus(button, '비활성');
        }
    } else {
        if (confirm('해당 디바이스와 연결 하시겠습니까?')) {
            button.innerText = '연결 해제';
            button.classList.remove('btn-success');
            button.classList.add('btn-danger');
            // 연결 작업 수행
            // 이 곳에 연결 동작에 관련된 코드를 추가
            updateConnectionStatus(button, '활성');
        }
    }
}

// 연결 상태 업데이트 함수
function updateConnectionStatus(button, status) {
    // 부모 <tr> 요소 찾기
    var row = button.closest('tr');
    // 상태 업데이트
    row.cells[2].innerText = status;
}

	
    </script>
</body>

</html>