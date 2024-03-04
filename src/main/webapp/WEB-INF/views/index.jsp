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
	var realtimeChart;
	var chart2; // 전역으로 선언
	var chart3;
	var chart4;
    document.addEventListener("DOMContentLoaded", function () {
    	// 그래프 1 (실시간 업데이트) 
        var ctx1 = document.getElementById("realtimeChart").getContext('2d');
        var data1 = [30, 50, 25, 45, 35, 55];
        var backgroundColor1 = 'rgba(255, 99, 132, 0.2)';
        var borderColor1 = 'rgba(255, 99, 132, 1)';
        var borderWidth1 = 1;

        realtimeChart = new Chart(ctx1, {
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
            // 새로운 데이터 가져와서 업데이트
            var newData1 = [30, 50, 25, 45, 35, 55];
            realtimeChart.data.datasets[0].data = newData1;
            realtimeChart.update();
        }, 5000);

        // 그래프 2 (일일 오탁수 처리량)
        var ctx2 = document.getElementById("graph3").getContext('2d');
        var data2 = [12, 19, 3, 5, 2, 3];
        var backgroundColor2 = 'rgba(54, 162, 235, 0.2)';
        var borderColor2 = 'rgba(54, 162, 235, 1)';
        var borderWidth2 = 1;

        chart2 = new Chart(ctx2, {
            type: 'bar',
            data: {
                labels: [], // 초기에는 빈 배열
                datasets: [{
                    label: '일일 오탁수 처리량',
                    data: data2,
                    backgroundColor: backgroundColor2,
                    borderColor: borderColor2,
                    borderWidth: borderWidth2
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
        var ctx3 = document.getElementById("dailyChart").getContext('2d');
        var data3 = [5, 2, 6, 2, 7, 9];
        var backgroundColor3 = 'rgba(255, 206, 86, 0.2)';
        var borderColor3 = 'rgba(255, 206, 86, 1)';
        var borderWidth3 = 1;

        chart3 = new Chart(ctx3, {
            type: 'line',
            data: {
                labels: [], // 초기에는 빈 배열
                datasets: [{
                    label: '실시간 유입량',
                    data: data3,
                    backgroundColor: backgroundColor3,
                    borderColor: borderColor3,
                    borderWidth: borderWidth3
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
            // 새로운 데이터 가져와서 업데이트
            var newData3 = [5, 2, 6, 2, 7, 9];
            chart3.data.datasets[0].data = newData3;
            chart3.update();
        }, 5000);

        // 그래프 4 (일일 유입량)
        var ctx4 = document.getElementById('dailyInflowChart').getContext('2d');
        chart4 = new Chart(ctx4, {
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
    
    var graphData = [];
    var todayOutFlowValue = 0;
    var todayMinus1OutFlowValue = 0;
    var todayMinus2OutFlowValue = 0;
    var todayMinus3OutFlowValue = 0;
    var todayMinus4OutFlowValue = 0;
    var todayMinus5OutFlowValue = 0;

    var todayInFlowValue = 0;
    var todayMinus1InFlowValue = 0;
    var todayMinus2InFlowValue = 0;
    var todayMinus3InFlowValue = 0;
    var todayMinus4InFlowValue = 0;
    var todayMinus5InFlowValue = 0;

    window.onload = function () {
        $.ajax({
            url: "/final/getDailyGraphData",
            type: "GET",
            success: function (response) {
                graphData = response;
                console.log(graphData);
                processData(); // 데이터 처리 함수 호출
            },
            error: function (xhr, status, error) {
                alert("그래프 데이터 받아오기 실패")
            }
        });
    };

    function processData() {
        var today = new Date();
        var todayString = today.toISOString().slice(0, 10);

        for (var i = 0; i < graphData.length; i++) {
            var date = graphData[i][1].slice(0, 10); // 각 데이터에서 날짜 부분만 추출
            var outFlowValue = graphData[i][7]; // 각 데이터의 OutFlow 값
            var inFlowValue = graphData[i][6]; // 각 데이터의 InFlow 값
            var diffDays = Math.floor((today - new Date(date)) / (1000 * 60 * 60 * 24)); // 오늘로부터의 차이 일수 계산

            switch (diffDays) {
                case 0:
                    todayOutFlowValue += outFlowValue;
                    todayInFlowValue += inFlowValue;
                    break;
                case 1:
                    todayMinus1OutFlowValue += outFlowValue;
                    todayMinus1InFlowValue += inFlowValue;
                    break;
                case 2:
                    todayMinus2OutFlowValue += outFlowValue;
                    todayMinus2InFlowValue += inFlowValue;
                    break;
                case 3:
                    todayMinus3OutFlowValue += outFlowValue;
                    todayMinus3InFlowValue += inFlowValue;
                    break;
                case 4:
                    todayMinus4OutFlowValue += outFlowValue;
                    todayMinus4InFlowValue += inFlowValue;
                    break;
                case 5:
                    todayMinus5OutFlowValue += outFlowValue;
                    todayMinus5InFlowValue += inFlowValue;
                    break;
                default:
                    break;
            }
        }

        console.log(todayOutFlowValue);
        console.log(todayMinus1OutFlowValue);
        console.log(todayMinus2OutFlowValue);
        console.log(todayMinus3OutFlowValue);
        console.log(todayMinus4OutFlowValue);
        console.log(todayMinus5OutFlowValue);
        
        console.log(todayInFlowValue);
        console.log(todayMinus1InFlowValue);
        console.log(todayMinus2InFlowValue);
        console.log(todayMinus3InFlowValue);
        console.log(todayMinus4InFlowValue);
        console.log(todayMinus5InFlowValue);

        // OutFlow 데이터 갱신
        var newOutFlowData = [todayMinus5OutFlowValue, todayMinus4OutFlowValue, todayMinus3OutFlowValue, todayMinus2OutFlowValue, todayMinus1OutFlowValue, todayOutFlowValue];
        var newOutFlowLabels = [];
        for (var i = 5; i >= 0; i--) {
            var currentDate = new Date(today);
            currentDate.setDate(today.getDate() - i);
            newOutFlowLabels.push(currentDate.toISOString().split('T')[0]);
        }

        // OutFlow 그래프에 데이터 및 라벨 할당
        chart2.data.labels = newOutFlowLabels;
        chart2.data.datasets[0].data = newOutFlowData;

        // OutFlow 그래프 업데이트
        chart2.update();

        // InFlow 데이터 갱신
        var newInFlowData = [todayMinus5InFlowValue, todayMinus4InFlowValue, todayMinus3InFlowValue, todayMinus2InFlowValue, todayMinus1InFlowValue, todayInFlowValue];
        var newInFlowLabels = [];
        for (var i = 5; i >= 0; i--) {
            var currentDate = new Date(today);
            currentDate.setDate(today.getDate() - i);
            newInFlowLabels.push(currentDate.toISOString().split('T')[0]);
        }

        // InFlow 그래프에 데이터 및 라벨 할당
        chart4.data.labels = newInFlowLabels;
        chart4.data.datasets[0].data = newInFlowData;

        // InFlow 그래프 업데이트
        chart4.update();
    }
    
    	
	</script>
</body>
</html>
