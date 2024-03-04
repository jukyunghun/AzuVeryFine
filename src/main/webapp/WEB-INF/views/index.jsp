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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
						<!-- 그래프 1 (실시간 오탁수 처리량) -->
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
									<i class="fas fa-chart-line me-1"></i> 일일 오탁수 처리량
								</div>
								<div class="card-body">
									<canvas id="graph3" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>

						<!-- 오염도 게이지 -->
						<div class="col-xl-4">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-tint me-1"></i> 오염도 표시 (<span
										id="pollutionValue">0</span> NTU)
								</div>
								<div class="card-body">
									<div class="progress">
										<div id="pollutionGauge" class="progress-bar"
											role="progressbar" style="width: 0%" aria-valuenow="0"
											aria-valuemin="0" aria-valuemax="100"></div>
									</div>
									<div class="mt-3">
										<small class="text-muted">오염도 단계 : <span
											id="pollutionLevel"></span></small>
									</div>
								</div>
							</div>
						</div>

						<!-- 그래프 3 (실시간 유입량) -->
						<div class="col-xl-4">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-area me-1"></i> 실시간 유입량
								</div>
								<div class="card-body">
									<canvas id="dailyChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>

						<!-- 그래프 4 (일일 유입량) -->
						<div class="col-xl-4">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-line me-1"></i> 일일 유입량
								</div>
								<div class="card-body">
									<canvas id="dailyInflowChart" width="100%" height="40"></canvas>
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
	<script src="/final/assets/js/scripts2.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script>
        document.addEventListener("DOMContentLoaded", function () {
        	// 그래프 1 (실시간 업데이트) 
            var ctx1 = document.getElementById("realtimeChart").getContext('2d');
            var data1 = [30, 50, 25, 45, 35, 55];
            var backgroundColor1 = 'rgba(255, 99, 132, 0.2)';
            var borderColor1 = 'rgba(255, 99, 132, 1)';
            var borderWidth1 = 1;

            var realtimeChart = new Chart(ctx1, {
                type: 'line',
                data: {
                    labels: [], // 초기에는 빈 배열
                    datasets: [{
                        label: '실시간 오탁수 처리량',
                        data: data1,
                        backgroundColor: backgroundColor1,
                        borderColor: borderColor1,
                        borderWidth: borderWidth1
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
                for (var i = 0; i < data1.length; i++) {
                    newData.push(Math.floor(Math.random() * 50)); // 임의값 생성
                }

                // 가장 오래된 값을 제거하고 새로운 값을 추가
                data1.shift();
                data1.push(newData[newData.length - 2]); // 가장 마지막에서 2번째 값으로 대체

                // 가장 최근의 시간을 라벨에 추가
                var now = new Date();
                realtimeChart.data.labels.push(now.toLocaleTimeString('en-US', { hour12: false }));
                
                // 라벨이 6개 이상이면 가장 오래된 라벨 제거
                if (realtimeChart.data.labels.length > 6) {
                    realtimeChart.data.labels.shift();
                }

                // 차트 업데이트
                realtimeChart.data.datasets[0].data = data1;
                realtimeChart.update();
            }, 5000); // 5초마다 차트 업데이트

         // 그래프 2 (일일 오탁수 처리량)
            var ctx2 = document.getElementById('graph3').getContext('2d');
            var chart2 = new Chart(ctx2, {
                type: 'bar',
                data: {
                    labels: [], // 초기에는 빈 배열
                    datasets: [{
                        label: '일일 오탁수 처리량',
                        data: [], // 초기에는 빈 배열
                        backgroundColor: 'rgba(255, 206, 86, 0.2)',
                        borderColor: 'rgba(255, 206, 86, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        },
                        x: {
                            type: 'time', // x 축을 시간 형식으로 사용
                            time: {
                                unit: 'day' // 날짜 단위로 표시
                            },
                            title: {
                                display: true,
                                text: '날짜'
                            }
                        }
                    }
                }
            });

            // 초기값 설정
            var initialData = [200, 350, 150, 300, 250, 400]; // 초기 임의값
            var initialLabels = [];
            var today = new Date();
            
            for (var i = 5; i >= 0; i--) {
                var currentDate = new Date(today);
                currentDate.setDate(today.getDate() - i);
                initialLabels.push(currentDate.toISOString().split('T')[0]);
            }

            chart2.data.labels = initialLabels;
            chart2.data.datasets[0].data = initialData;

            // 차트 초기 렌더링
            chart2.update();

            // 라벨만 업데이트 (매일 추가될 수 있도록)
            setInterval(function () {
                var oldDate = chart2.data.labels[0];
                var newDate = new Date(oldDate);
                newDate.setDate(newDate.getDate() + 1);
                var formattedNewDate = newDate.toISOString().split('T')[0];
                
                // 새로운 라벨을 가장 뒤에 추가
                chart2.data.labels.push(formattedNewDate);
                
                // 가장 앞의 값을 제거
                chart2.data.labels.shift();

                // 차트 업데이트
                chart2.update();
            }, 24 * 60 * 60 * 1000); // 24시간(1일)마다 라벨 추가 및 차트 업데이트
            

            // 오염도 게이지 업데이트 함수
 			function updatePollutionGauge(value) {
                var pollutionGauge = document.getElementById('pollutionGauge');
                var pollutionValue = document.getElementById('pollutionValue');
                var pollutionLevel = document.getElementById('pollutionLevel');

                pollutionGauge.style.width = (value / 300 * 100) + '%'; // 최대값을 300으로 설정
                pollutionGauge.setAttribute('aria-valuenow', value);
                pollutionGauge.setAttribute('aria-valuemax', 300); // 최대값을 300으로 설정

                pollutionValue.innerText = value; // 현재 오염도 값 업데이트

                // 오염도 단계에 따른 텍스트 표시
                if (value >= 200) {
                    pollutionLevel.innerText = '5단계';
                } else if (value >= 100) {
                    pollutionLevel.innerText = '4단계';
                } else if (value >= 50) {
                    pollutionLevel.innerText = '3단계';
                } else if (value >= 25) {
                    pollutionLevel.innerText = '2단계';
                } else {
                    pollutionLevel.innerText = '1단계';
                }

                // 오염도에 따른 색상 변경
                if (value >= 200) {
                    pollutionGauge.classList.remove('bg-info', 'bg-success', 'bg-warning');
                    pollutionGauge.classList.add('bg-danger');
                } else if (value >= 100) {
                    pollutionGauge.classList.remove('bg-info', 'bg-success', 'bg-danger');
                    pollutionGauge.classList.add('bg-warning');
                } else if (value >= 50) {
                    pollutionGauge.classList.remove('bg-info', 'bg-danger', 'bg-warning');
                    pollutionGauge.classList.add('bg-success');
                } else {
                    pollutionGauge.classList.remove('bg-danger', 'bg-success', 'bg-warning');
                    pollutionGauge.classList.add('bg-info');
                }
            }

            // 오염도 게이지 초기화
            updatePollutionGauge(0);

            // 오염도 게이지 임의값 부여
            setInterval(function () {
                var newValue = Math.floor(Math.random() * 300); // 랜덤값 설정
                updatePollutionGauge(newValue);
            }, 10000); // 10초마다 업데이트

         // 그래프 3 (실시간 유입량)
            var ctx3 = document.getElementById('dailyChart').getContext('2d');
            var labels3 = [];
            var data3 = [25, 40, 20, 35, 30, 45];

            var chart3 = new Chart(ctx3, {
                type: 'line',
                data: {
                    labels: labels3,
                    datasets: [{
                        label: '실시간 유입량',
                        data: data3,
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

            setInterval(function () {
                // 새로운 데이터 생성
                var newData = [];
                for (var i = 0; i < chart3.data.datasets[0].data.length; i++) {
                    newData.push(Math.floor(Math.random() * 50)); // 임의값 생성
                }

                // 가장 오래된 값을 제거하고 새로운 값을 추가
                chart3.data.datasets[0].data.shift();
                chart3.data.datasets[0].data.push(newData[newData.length - 2]); // 가장 마지막에서 2번째 값으로 대체

                // 가장 최근의 시간을 라벨에 추가
                var now3 = new Date();
                chart3.data.labels.push(now3.toLocaleTimeString('en-US', { hour12: false }));

                // 라벨이 6개 이상이면 가장 오래된 라벨 제거
                if (chart3.data.labels.length > 6) {
                    chart3.data.labels.shift();
                }

                // 차트 업데이트
                chart3.update();
            }, 5000); // 5초마다 차트 업데이트

            setInterval(function () {
                // 새로운 데이터 생성
                var newData = [];
                for (var i = 0; i < chart3.data.datasets[0].data.length; i++) {
                    newData.push(Math.floor(Math.random() * 50)); // 임의값 생성
                }

                // 가장 오래된 값을 제거하고 새로운 값을 추가
                chart3.data.datasets[0].data.shift();
                chart3.data.datasets[0].data.push(newData[newData.length - 2]); // 가장 마지막에서 2번째 값으로 대체

                // 차트 업데이트
                chart3.update();
            }, 5000); // 5초마다 차트 업데이트

         // 그래프 4 (일일 유입량)
            var ctx4 = document.getElementById('dailyInflowChart').getContext('2d');
            var chart4 = new Chart(ctx4, {
                type: 'bar',
                data: {
                    labels: [], // 초기에는 빈 배열 (그래프 밑 날짜 표시)
                    datasets: [{
                        label: '일일 유입량',
                        data: [], // 초기에는 빈 배열
                        backgroundColor: 'rgba(153, 102, 255, 0.2)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        },
                        x: {
                            type: 'time', // x 축을 시간 형식으로 사용
                            time: {
                                unit: 'day' // 날짜 단위로 표시
                            },
                            title: {
                                display: true,
                                text: '날짜'
                            }
                        }
                    }
                }
            });

            // 초기값 설정
            var initialData4 = [150, 250, 300, 200, 350, 400]; // 초기 임의값
            var initialLabels4 = [];
            var today4 = new Date();

            for (var i = 5; i >= 0; i--) {
                var currentDate4 = new Date(today4);
                currentDate4.setDate(today4.getDate() - i);
                initialLabels4.push(currentDate4.toISOString().split('T')[0]);
            }

            chart4.data.labels = initialLabels4;
            chart4.data.datasets[0].data = initialData4;

            // 차트 초기 렌더링
            chart4.update();

            // 라벨만 업데이트 (매일 추가될 수 있도록)
            setInterval(function () {
                var oldDate4 = chart4.data.labels[0];
                var newDate4 = new Date(oldDate4);
                newDate4.setDate(newDate4.getDate() + 1);
                var formattedNewDate4 = newDate4.toISOString().split('T')[0];

                // 새로운 라벨을 가장 뒤에 추가
                chart4.data.labels.push(formattedNewDate4);

                // 가장 앞의 값을 제거
                chart4.data.labels.shift();

                // 차트 업데이트
                chart4.update();
            }, 24 * 60 * 60 * 1000); // 24시간(1일)마다 라벨 추가 및 차트 업데이트
        });
    </script>

	<script type="text/javascript">

/*!
 * Start Bootstrap - SB Admin v7.0.7 (https://startbootstrap.com/template/sb-admin)
 * Copyright 2013-2023 Start Bootstrap
 * Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-sb-admin/blob/master/LICENSE)
 */
 // 
//Scripts
//

window.addEventListener('DOMContentLoaded', event => {

 // Toggle the side navigation
 const sidebarToggle = document.body.querySelector('#sidebarToggle');
 if (sidebarToggle) {
     // Uncomment Below to persist sidebar toggle between refreshes
     // if (localStorage.getItem('sb|sidebar-toggle') === 'true') {
     //     document.body.classList.toggle('sb-sidenav-toggled');
     // }
     sidebarToggle.addEventListener('click', event => {
         event.preventDefault();
         document.body.classList.toggle('sb-sidenav-toggled');
         localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
     });
 }

});
</script>
        
        <script type="text/javascript">
        
	    let graphData;
        window.onload = function() {
            $.ajax({
                url: "/final/getDailyGraphData",
                type: "GET",
                success: function(response) {
                    graphData = response;
                    console.log(graphData);
                    console.log(response);
                },
                error: function(xhr, status, error) {
                    alert("그래프 데이터 받아오기 실패")
                }
            });
        };
        
        
        
    </script>
</body>
</html>