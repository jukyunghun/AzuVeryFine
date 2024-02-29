<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>오탁수 처리량 - SB Admin</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet">
<link href="/final/assets/css/styles.css" rel="stylesheet">

<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>

<body class="sb-nav-fixed">
	<jsp:include page="nav/navbar.jsp" />
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<jsp:include page="nav/sidebar.jsp" />
		</div>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4" style="font-weight: bold;">오탁수 처리량</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">오탁수 처리량</li>
					</ol>

					<!-- 그래프 표시  -->
					<div class="row">
						<div class="col-xl-4">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-area me-1"></i> 실시간 오탁수 처리량
								</div>
								<div class="card-body">
									<canvas id="realtimeChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>

						<!-- 그래프 2 (일일 오탁수 처리량) -->
						<div class="col-xl-4">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-bar me-1"></i> 일일 오탁수 처리량
								</div>
								<div class="card-body">
									<canvas id="dailyChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>

						<!-- 그래프 3 -->
						<div class="col-xl-4">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-line me-1"></i> 그래프 3
								</div>
								<div class="card-body">
									<canvas id="graph3" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>

						<!-- 그래프 4 -->
						<div class="col-xl-4">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-line me-1"></i> 그래프 4
								</div>
								<div class="card-body">
									<canvas id="graph4" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>

						<!-- 그래프 5 -->
						<div class="col-xl-4">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-line me-1"></i> 그래프 5
								</div>
								<div class="card-body">
									<canvas id="graph5" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
			<jsp:include page="nav/footer.jsp" />
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/final/assets/js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script>
        document.addEventListener("DOMContentLoaded", function () {
            // 그래프 1 (실시간 업데이트) 
            var ctx = document.getElementById("realtimeChart").getContext('2d');
            var labels = ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"];
            var data = [30, 50, 25, 45, 35, 55];
            var backgroundColor = 'rgba(255, 99, 132, 0.2)';
            var borderColor = 'rgba(255, 99, 132, 1)';
            var borderWidth = 1;

            var realtimeChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '실시간 오탁수 처리량',
                        data: data,
                        backgroundColor: backgroundColor,
                        borderColor: borderColor,
                        borderWidth: borderWidth
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            setInterval(function () {
                // 새로운 데이터 생성
                var newData = [];
                for (var i = 0; i < data.length; i++) {
                    newData.push(Math.floor(Math.random() * 50)); // 임의값 생성
                }

                // 가장 오래된 값을 제거하고 새로운 값을 추가
                data.shift();
                data.push(newData[newData.length - 2]); // 가장 마지막에서 2번째 값으로 대체

                // 차트 업데이트
                realtimeChart.data.datasets[0].data = data;
                realtimeChart.update();
            }, 5000); // 5초마다 차트 업데이트

            // 나머지 네 개의 그래프에 임의값 부여
            var chart2 = new Chart(document.getElementById('dailyChart').getContext('2d'), {
                type: 'bar',
                data: {
                    labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
                    datasets: [{
                        label: '일일 오탁수 처리량',
                        data: [25, 40, 20, 35, 30, 45],
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            var chart3 = new Chart(document.getElementById('graph3').getContext('2d'), {
                type: 'line',
                data: {
                    labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
                    datasets: [{
                        label: '그래프 3',
                        data: [20, 35, 15, 30, 25, 40],
                        backgroundColor: 'rgba(255, 206, 86, 0.2)',
                        borderColor: 'rgba(255, 206, 86, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            var chart4 = new Chart(document.getElementById('graph4').getContext('2d'), {
                type: 'line',
                data: {
                    labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
                    datasets: [{
                        label: '그래프 4',
                        data: [18, 32, 10, 28, 20, 38],
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            var chart5 = new Chart(document.getElementById('graph5').getContext('2d'), {
                type: 'line',
                data: {
                    labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
                    datasets: [{
                        label: '그래프 5',
                        data: [15, 28, 8, 25, 18, 30],
                        backgroundColor: 'rgba(153, 102, 255, 0.2)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
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
        
        let token;
        
        axios.interceptors.request.use(async config => {
        	token = '${token}'; // 모델에 추가된 token 속성의 값
        	if(!token){
            	token = await getCookie('token'); // 쿠키에서 토큰을 가져옴        		
        	}
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