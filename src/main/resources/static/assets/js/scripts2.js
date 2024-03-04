/*!
    * Start Bootstrap - SB Admin v7.0.7 (https://startbootstrap.com/template/sb-admin)
    * Copyright 2013-2023 Start Bootstrap
    * Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-sb-admin/blob/master/LICENSE)
    */
    // 
// Scripts
// 

window.addEventListener('DOMContentLoaded', event => {

    // 추가된 부분: 센서 데이터 확인 함수
    function checkSensorData() {
        $.get("/final/getGraphData", function(data) {
        
        	console.log(data);
        	
            // 센서 데이터를 확인하고 조건에 따라 알림 표시
            if (data.phValue >= 14 || data.phValue === null) {
                alert("산도값이 이상합니다.");
            }
            if (data.turbidValue > 250 || data.turbidValue === null) {
                alert("탁도값이 이상합니다.");
            }
            if (data.flowValue === null) {
                alert("유량값이 이상합니다.");
            }
        });
    }

    // 일정 시간마다 checkSensorData 함수 호출
    setInterval(checkSensorData, 5000); // 5초마다 호출

});